using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using mojGradApp.BL;
using mojGradApp.BL.Interfaces;
using mojGradApp.DAL;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Hubs;
using mojGradApp.UI;
using mojGradApp.UI.Interfaces;

namespace mojGradApp
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //----------------------ZA TOKEN----------------------
           /* services.AddCors(options =>
            {
                options.AddPolicy("CorsPolicy", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader().AllowCredentials().Build());
            });
            */

            services.AddCors(o => o.AddPolicy("MyPolicy", builder =>
            {
                builder.AllowAnyOrigin()
                       .AllowAnyMethod()
                       .AllowAnyHeader();
            }));

            services.AddControllers();

            services.AddControllers().AddNewtonsoftJson(options =>
                options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
            );

            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = Configuration["Jwt:Issuer"],
                        ValidAudience = Configuration["Jwt:Issuer"],
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]))
                    };
                });
            services.AddMvc();
            //----------------------KRAJ TOKENA----------------------

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Latest);
            services.AddSignalR();

            services.AddDbContext<ApplicationDbContext>();

            services.AddTransient<IAdminsUI, AdminsUI>();
            services.AddTransient<ICategoriesUI, CategoriesUI>();
            services.AddTransient<ICitiesUI, CitiesUI>();
            services.AddTransient<IPostsUI, PostsUI>();
            services.AddTransient<ITypesUI, TypesUI>();
            services.AddTransient<IUserDatasUI, UserDatasUI>();
            services.AddTransient<ICommentReactionsUI, CommentReactionsUI>();
            services.AddTransient<ICommentsUI, CommentsUI>();
            services.AddTransient<INotificationsUI, NotificationsUI>();
            services.AddTransient<IPostReactionsUI, PostReactionsUI>();
            services.AddTransient<IPostReportsUI, PostReportsUI>();
            services.AddTransient<IUserReportsUI, UserReportsUI>();
            services.AddTransient<IRanksUI, RanksUI>();
			services.AddTransient<IFollowsUI, FollowsUI>();

            services.AddTransient<IAdminsBL, AdminsBL>();
            services.AddTransient<ICategoriesBL, CategoriesBL>();
            services.AddTransient<ICitiesBL, CitiesBL>();
            services.AddTransient<IPostsBL, PostsBL>();
            services.AddTransient<ITypesBL, TypesBL>();
            services.AddTransient<IUserDatasBL, UserDatasBL>();
            services.AddTransient<ICommentReactionsBL, CommentReactionsBL>();
            services.AddTransient<ICommentsBL, CommentsBL>();
            services.AddTransient<INotificationsBL, NotificationsBL>();
            services.AddTransient<IPostReactionsBL, PostReactionsBL>();
            services.AddTransient<IPostReportsBL, PostReportsBL>();
            services.AddTransient<IUserReportsBL, UserReportsBL>();
            services.AddTransient<IRanksBL, RanksBL>();
			services.AddTransient<IFollowsBL, FollowsBL>();

            services.AddTransient<IAdminsDAL, AdminsDAL>();
            services.AddTransient<ICategoriesDAL, CategoriesDAL>();
            services.AddTransient<ICitiesDAL, CitiesDAL>();
            services.AddTransient<IPostsDAL, PostsDAL>();
            services.AddTransient<ITypesDAL, TypesDAL>();
            services.AddTransient<IUserDatasDAL, UserDatasDAL>();
            services.AddTransient<ICommentReactionsDAL, CommentReactionsDAL>();
            services.AddTransient<ICommentsDAL, CommentsDAL>();
            services.AddTransient<INotificationsDAL, NotificationsDAL>();
            services.AddTransient<IPostReactionsDAL, PostReactionsDAL>();
            services.AddTransient<IPostReportsDAL, PostReportsDAL>();
            services.AddTransient<IUserReportsDAL, UserReportsDAL>();
            services.AddTransient<IRanksDAL, RanksDAL>();
			services.AddTransient<IFollowsDAL, FollowsDAL>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }

            app.UseCors("MyPolicy");

            app.UseHttpsRedirection();

            app.UseRouting();

            //----------------------TOKEN----------------------
            app.UseAuthentication();
            //----------------------KRAJ TOKENA----------------------   

            app.UseAuthorization();

            app.UseStaticFiles();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });


            //app.Run(async (context) =>
            //{
            //    await context.Response.WriteAsync("Could not find anything");
            //});

            // for notification
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapHub<NotificationHub>("/livenotification");
            });
        }
    }
}
