using Microsoft.EntityFrameworkCore;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Data
{
    public class ApplicationDbContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite(@"Data Source = baza.db");
        }

        public DbSet<Categories> Category { get; set; }
        public DbSet<Cities> City { get; set; }
        public DbSet<Posts> Post { get; set; }
        public DbSet<Types> Type { get; set; }
        public DbSet<UserDatas> User { get; set; }
        public DbSet<Admins> Admin { get; set; }
		public DbSet<Comments> Comment { get; set; }
        public DbSet<CommentReaction> CommentReaction { get; set; }
        public DbSet<PostReactions> PostReaction { get; set; }
        public DbSet<PostReports> PostReport { get; set; }
        public DbSet<UserReports> UserReport { get; set; }
        public DbSet<Ranks> Rank { get; set; }
        public DbSet<RankChanges> RankChange { get; set; }
        public DbSet<UserTypes> UserType { get; set; }
		public DbSet<Follows> Follow { get; set; }
        public DbSet<ChallengeAndSolutions> ChallengeAndSolution { get; set; }
        public DbSet<CategoryFollows> CategoryFollow { get; set; }
        public DbSet<Points> Point { get; set; }
        public DbSet<Sponsors> Sponsor { get; set; }
		public DbSet<SavedPosts> SavedPost { get; set; }
        public DbSet<Messages> Message { get; set; }
        public DbSet<UserStatistics> UserStatistic { get; set; }
    }
}
