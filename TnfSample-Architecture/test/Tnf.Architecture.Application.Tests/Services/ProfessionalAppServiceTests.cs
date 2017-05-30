﻿using Tnf.App.EntityFrameworkCore.TestBase;
using Tnf.Architecture.EntityFrameworkCore;
using Xunit;
using Shouldly;
using Tnf.Architecture.EntityFrameworkCore.Entities;
using Tnf.Architecture.Dto.ValueObjects;
using Tnf.Architecture.Application.Interfaces;
using Tnf.Architecture.Dto.Registration;
using Tnf.Architecture.Dto.Enumerables;
using System.Collections.Generic;
using System.Linq;
using Tnf.Architecture.Domain.Registration;
using Tnf.Dto.Response;
using Tnf.Dto.Request;
using System;

namespace Tnf.Architecture.Application.Tests.Services
{
    public class ProfessionalAppServiceTests : TnfEfCoreIntegratedTestBase<EfCoreAppTestModule>
    {
        private readonly IProfessionalAppService _professionalAppService;
        private readonly ProfessionalPoco _professionalPoco;

        public ProfessionalAppServiceTests()
        {
            _professionalAppService = Resolve<IProfessionalAppService>();

            _professionalPoco = new ProfessionalPoco()
            {
                ProfessionalId = 1,
                Code = Guid.NewGuid(),
                Address = "Rua do comercio",
                AddressNumber = "123",
                AddressComplement = "APT 123",
                Email = "email@email.com",
                Name = "João da Silva",
                Phone = "55998765432",
                ZipCode = "99888777"
            };

            // Setup
            UsingDbContext<LegacyDbContext>(context =>
            {
                context.Professionals.Add(_professionalPoco);
                context.Specialties.Add(new SpecialtyPoco() { Id = 1, Description = "Anestesiologia" });                
            });
        }

        [Fact]
        public void Should_Get_All_Professionals_With_Success()
        {
            //Act
            var response = _professionalAppService.GetAllProfessionals(new GetAllProfessionalsDto() { PageSize = 10 });

            //Assert
            Assert.True(response.Success);
            Assert.IsType(typeof(SuccessResponseListDto<ProfessionalDto>), response);
            var successResponse = response as SuccessResponseListDto<ProfessionalDto>;
            successResponse.Items.Count.ShouldBe(1);
        }

        [Fact]
        public void Should_Get_All_Professionals_With_Error()
        {
            //Act
            var response = _professionalAppService.GetAllProfessionals(new GetAllProfessionalsDto());

            //Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            errorResponse.Message.ShouldBe("InvalidParameter");
            errorResponse.DetailedMessage.ShouldBe("InvalidParameter");
            Assert.True(errorResponse.Notifications.Any(n => n.Message == Error.InvalidParameterDynamic.ToString()));
        }

        [Fact]
        public void Should_Insert_Professional_With_Success()
        {
            //Arrange
            var professionalDto = new ProfessionalDto()
            {
                ProfessionalId = 2,
                Code = Guid.Parse("1b92f96f-6a71-4655-a0b9-93c5f6ad9637"),
                Address = new Address("Rua teste", "98765", "APT 9876", new ZipCode("23156478")),
                Email = "email1234@email.com",
                Name = "Jose da Silva",
                Phone = "58962348",
                Specialties = new List<SpecialtyDto>()
                {
                    new SpecialtyDto() { Id = 1, Description = "Anestesiologia" }
                }
            };

            //Act
            var result = _professionalAppService.CreateProfessional(professionalDto);

            //Assert
            result.Success.ShouldBeTrue();
            Assert.IsType(typeof(ProfessionalDto), result);
            (result as ProfessionalDto).ProfessionalId.ShouldBe(2);
        }

        [Fact]
        public void Should_Insert_Professional_With_Error()
        {
            // Act
            var response = _professionalAppService.CreateProfessional(new ProfessionalDto());

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalAddressComplementMustHaveValue.ToString()));
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalAddressMustHaveValue.ToString()));
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalAddressNumberMustHaveValue.ToString()));
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalEmailMustHaveValue.ToString()));
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalNameMustHaveValue.ToString()));
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalPhoneMustHaveValue.ToString()));
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.ProfessionalZipCodeMustHaveValue.ToString()));
        }

        [Fact]
        public void Should_Insert_Null_Professional_With_Error()
        {
            // Act
            var response = _professionalAppService.CreateProfessional(null);

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            errorResponse.Message.ShouldBe("InvalidParameter");
            errorResponse.DetailedMessage.ShouldBe("InvalidParameter");
            Assert.True(errorResponse.Notifications.Any(n => n.Message == Error.InvalidParameterDynamic.ToString()));
        }

        [Fact]
        public void Should_Update_Professional_With_Success()
        {
            //Arrange
            var professionalDto = new ProfessionalDto()
            {
                ProfessionalId = 2,
                Code = Guid.Parse("1b92f96f-6a71-4655-a0b9-93c5f6ad9637"),
                Address = new Address("Rua teste", "98765", "APT 9876", new ZipCode("23156478")),
                Email = "email1234@email.com",
                Name = "Jose da Silva",
                Phone = "58962348",
                Specialties = new List<SpecialtyDto>()
                {
                    new SpecialtyDto() { Id = 1, Description = "Anestesiologia" }
                }
            };

            //Act
            var result = _professionalAppService.CreateProfessional(professionalDto);

            //Assert
            result.Success.ShouldBeTrue();
            Assert.IsType(typeof(ProfessionalDto), result);
            var professional = result as ProfessionalDto;

            professional.ProfessionalId.ShouldBe(2);

            professional.Name = "Nome Alterado Teste";

            professional.Specialties.Clear();
            result = _professionalAppService.UpdateProfessional(new ProfessionalKeysDto(professional.ProfessionalId, professional.Code), professional);

            //Assert
            result.Success.ShouldBeTrue();
            Assert.IsType(typeof(ProfessionalDto), result);
            professional = result as ProfessionalDto;
            professional.Name.ShouldBe("Nome Alterado Teste");
        }

        [Fact]
        public void Should_Update_Professional_With_Error()
        {
            // Arrange
            var professionalDto = new ProfessionalDto()
            {
                ProfessionalId = 99,
                Code = Guid.NewGuid(),
                Address = new Address("Rua teste", "98765", "APT 9876", new ZipCode("23156478")),
                Email = "email1234@email.com",
                Name = "Jose da Silva",
                Phone = "58962348",
                Specialties = new List<SpecialtyDto>()
                {
                    new SpecialtyDto() { Id = 1, Description = "Anestesiologia" }
                }
            };

            //Act
            var response = _professionalAppService.UpdateProfessional(new ProfessionalKeysDto(professionalDto.ProfessionalId, professionalDto.Code), professionalDto);

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.CouldNotFindProfessional.ToString()));
        }

        [Fact]
        public void Should_Update_Invalid_Id_With_Error()
        {
            // Act
            var response = _professionalAppService.UpdateProfessional(new ProfessionalKeysDto(0, Guid.Empty), new ProfessionalDto());

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            errorResponse.Message.ShouldBe("InvalidParameter");
            errorResponse.DetailedMessage.ShouldBe("InvalidParameter");
            Assert.True(errorResponse.Notifications.Any(n => n.Message == Error.InvalidParameterDynamic.ToString()));
        }

        [Fact]
        public void Should_Update_Null_Professional_With_Error()
        {
            // Act
            var response = _professionalAppService.UpdateProfessional(new ProfessionalKeysDto(1, Guid.NewGuid()), null);

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            errorResponse.Message.ShouldBe("InvalidParameter");
            errorResponse.DetailedMessage.ShouldBe("InvalidParameter");
            Assert.True(errorResponse.Notifications.Any(n => n.Message == Error.InvalidParameterDynamic.ToString()));
        }

        [Fact]
        public void Should_Get_Professional_With_Success()
        {
            //Act
            var response = _professionalAppService.GetProfessional(new RequestDto<ProfessionalKeysDto>(new ProfessionalKeysDto(1, _professionalPoco.Code)));

            //Assert
            Assert.True(response.Success);
            Assert.IsType(typeof(ProfessionalDto), response);
            var successResponse = response as ProfessionalDto;
            successResponse.ProfessionalId.ShouldBe(1);
            successResponse.Code.ShouldBe(_professionalPoco.Code);
        }

        [Fact]
        public void Should_Get_Professional_With_Error()
        {
            // Act
            var response = _professionalAppService.GetProfessional(new RequestDto<ProfessionalKeysDto>(new ProfessionalKeysDto(99, _professionalPoco.Code)));

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.CouldNotFindProfessional.ToString()));
        }

        [Fact]
        public void Should_Delete_Professional_With_Success()
        {
            //Act
            var response = _professionalAppService.DeleteProfessional(new ProfessionalKeysDto(1, _professionalPoco.Code));

            var count = _professionalAppService.GetAllProfessionals(new GetAllProfessionalsDto() { PageSize = 10 });

            //Assert
            Assert.True(response.Success);
            Assert.True(count.Success);
            Assert.IsType(typeof(SuccessResponseListDto<ProfessionalDto>), count);
            var successResponse = count as SuccessResponseListDto<ProfessionalDto>;
            successResponse.Items.ShouldBeEmpty();
        }

        [Fact]
        public void Should_Delete_Professional_With_Error()
        {
            // Act
            var response = _professionalAppService.DeleteProfessional(new ProfessionalKeysDto(99, _professionalPoco.Code));

            // Assert
            Assert.False(response.Success);
            Assert.IsType(typeof(ErrorResponseDto), response);
            var errorResponse = response as ErrorResponseDto;
            Assert.True(errorResponse.Notifications.Any(a => a.Message == Professional.Error.CouldNotFindProfessional.ToString()));
        }
    }
}
