﻿using System.Threading.Tasks;
using Tnf.App.Carol.Repositories;
using Tnf.App.Dto.Request;
using Tnf.App.Dto.Response;
using Tnf.Architecture.Carol.Entities;
using Tnf.Architecture.Carol.ReadInterfaces;
using Tnf.Architecture.Domain.Interfaces.Repositories;
using Tnf.Architecture.Domain.WhiteHouse;
using Tnf.Architecture.Dto.WhiteHouse;
using Tnf.AutoMapper;
using Tnf.Provider.Carol;

namespace Tnf.Architecture.Carol.Repositories
{
    public class WhiteHouseRepository : CarolRepositoryBase<PresidentPoco>, IWhiteHouseRepository
    {
        public WhiteHouseRepository(ICarolClient client) :
            base(client)
        {
        }

        public async Task<bool> DeletePresidentsAsync(string id)
        {
            return await DeleteAsync(id);
        }

        public async Task<President> GetPresidentById(RequestDto<string> requestDto)
        {
            var presidentData = await GetAsync(requestDto.GetId());

            return presidentData.MapTo<President>();
        }

        public async Task<string> InsertPresidentsAsync(President president)
        {
            var poco = president.MapTo<PresidentPoco>();

            var result = await InsertAsync(poco, false);

            return result.Id;
        }

        public async Task<President> UpdatePresidentsAsync(President president)
        {
            var poco = president.MapTo<PresidentPoco>();
            await UpdateAsync(poco);

            return president;
        }
    }
}
