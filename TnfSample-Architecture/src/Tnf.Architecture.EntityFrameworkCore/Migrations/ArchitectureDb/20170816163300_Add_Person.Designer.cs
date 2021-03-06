﻿using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Tnf.Architecture.EntityFrameworkCore.Contexts;

namespace Tnf.Architecture.EntityFrameworkCore.Migrations.ArchitectureDb
{
    [DbContext(typeof(ArchitectureDbContext))]
    [Migration("20170816163300_Add_Person")]
    partial class Add_Person
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
            modelBuilder
                .HasAnnotation("ProductVersion", "1.1.2")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("Tnf.Architecture.Domain.Registration.Person", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name");

                    b.HasKey("Id");

                    b.ToTable("People");
                });

            modelBuilder.Entity("Tnf.Architecture.EntityFrameworkCore.Entities.CountryPoco", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(256);

                    b.HasKey("Id");

                    b.ToTable("Countries");
                });
        }
    }
}
