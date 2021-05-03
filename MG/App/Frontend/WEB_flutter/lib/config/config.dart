//String url = 'http://127.0.0.1:58482/api'; //<-----ovaj?
String url = "http://147.91.204.116:2033/api";
String checkAdminURL = url + "/Admins/login";
String categoryURL = url + "/Categories";
String cityURL = url + "/Cities";
String postURL = url + "/Posts";
String typeURL = url + "/Types";
String userDataURL = url + "/UserDatas";
String loginURL = userDataURL + "/login/UserTypeID=";
String emailURL = userDataURL + "/email";
String usernameURL = userDataURL + "/username";
String commentURL = url + "/Comments";
String commentDislikeURL = url + "/CommentDislikes";
String commentLikeURL = url + "/CommentLikes";
String followURL = url + "/Follows";
String postReactionURL = url + "/PostReactions/NewPostReaction";
String postReportURL = url + "/PostReports";
String userReportURL = url + "/UserReports";
String getReportedUsersURL = userDataURL + "/GetReportedUsers";
String adminURL = url + "/Admins";
String changeUserInfoURL = userDataURL + "/ChangeInfo";
String wwwrootURL = "http://147.91.204.116:2033/";
//String wwwrootURL = "http://127.0.0.1:58482/";
String changePostInfoURL = postURL + "/ChangePostInfo";
String getpostReactionURL = url + "/GetPostReaction";
String commentReactionURL = url + "/CommentReactions";
String newCommentReactionURL = commentReactionURL + "/NewCommentReaction";
String getAllFollowersOfUserURL = followURL + "/user"; // + /{UserId}
String getAllPostsOfUserThatYouFOllowURL =
    followURL + "/GetPostOfFollowersByUserID"; // + /{UserId}
String checkIfFollowURL =
    followURL + "/IsThereAFollow"; // + /{userFollowID}/{followingUserID}
String getUsersThatReactedOnPostURL =
    userDataURL + "/GetUsersThatReacted/post"; // + /{postID}
String getUsersThatLikedCommentURL =
    userDataURL + "/GetUsersThatLiked/comment"; // + /{commentID}
String getUsersThatDislikedCommentURL =
    userDataURL + "/GetUsersThatDisliked/comment"; // + /{commentID}
String citizensURL = userDataURL + "/citizens"; // + /userId={userID}
String citizensFromCity =
    userDataURL + "/citizens"; // + /cityID={cityID}/userId={userID}
String addChallengeSolutionURL =
    postURL + "/AddChallengeSolution/ChallengeID="; // +/{challengeID}
String getChallengeOrSolutionURL = postURL +
    "/GetChallengeOrSolution"; // + /postID={postID}/IsApproved={IsApproved}

String addCategoryFollowURL = categoryURL +
    "/AddOrDeleteCategoryFollow"; //post metoda salje se CategoryFollow
String getCategoriesUserFollowURL =
    categoryURL + "/GetCategoriesYouFollow/"; // + {userID}
String getCategoriesUserDoesntFollowURL =
    categoryURL + "/GetCategoriesYouDontFollow/"; // + {userID}
String checkIfFollowCategoryURL =
    categoryURL + "/IsThereAFollow/"; // + {userID}/{categoryID}

String checkRangURL =
    userDataURL + "/CheckRang/userID="; // + {userID} GET metoda
String getBestUsersURL = userDataURL +
    "/GetBest"; // + /userTypeID={userTypeID}/days={days}/userNumber={userNumber}
String getPointsUserURL =
    userDataURL + "/GetPointsForUser"; // + /userID={userID}/days={days}

String closeChallengeURL =
    postURL + "/CloseChallenge"; // + /challengeID={challengeID} POST metoda
String solutionRejectedURL = postURL +
    "/ChallengeRejected"; // + /challengeID={challengeID}/solutionID={solutionID} POST metoda
String isSolutionApprovedURL =
    postURL + "/IsSolutionApproved/solutionID="; // +{solutionID}


String getFilteredPosts = postURL +
    "/getFilteredPosts"; // + /UserID={UserID}/cityID={cityID}/fromFollowers={fromFollowers}/activeChallenge={activeChallenge}/sortByReactions={sortByReactions}
// fromFollowers 0 uzima sve postove a 1 uzima samo postove ljudi koje prati, activeChallenge 0 uzima sve postove a 1 uzima samo postove koji su aktivni izazovi
// sortByReactions 0 sortira postove po vremenu a 1 sortira postove po broju reakcija ---- POST metoda, pored prosledjenog URLa treba proslediti u body-u listu kategorija ili prazan niz

String commentsWithDislikesURL = commentURL + "/commentsWithDislikes"; // + /userID={userID}
String getFollowSugestionsURL = userDataURL + "/followSugestions/userId="; // + {userID}
String imageUploadWebURL = url + "/ImageUpload/PostWeb";
String imageUploadForInstitution = url + '/ImageUpload/InstitutionWeb';

String postsByCityAndCategoryURL = postURL + "/city/"; // +{cityId}/category/{categoryId}";
String postsByCityURL = postURL + "/city/"; // + {id};
String postsByCategoryURL = postURL + "/category/"; //+ {id};

String getUserPostsFilteredByType = postURL +
    "/UserPostsFilteredByType"; // + /userID={userID}/typeID={typeID}/ - typeID 1 otvoren izazov, 2 resenje, 3 zavrsen izazov

String getReportedPosts = postURL + "/GetReportedPosts";
String getReportedComments = commentURL + "/commentsWithDislikes";
String getMostImportantPosts = postURL + "/GetMostImportantPost/"; // + cityID={cityID}/typeID={typeID}

String dissmissUserReports = userDataURL + "/DissmissUserReports/userID="; // + {userID}, vraca true/false
String getApprovedReportedUsers = userDataURL + "/GetApprovedReportedUsers"; // vraca listu UserInfo
String dissmissPostReports = postURL + "/DissmissPostReports/postID="; // + {postID}, vraca true/false
String getApprovedReportedPosts = postURL + "/GetApprovedReportedPosts"; // vraca listu PostInfo
String dissmissCommentReportsURL = commentURL + "/DissmissCommentReports/commentID="; // + {commentID}, vraca true/false
String getApprovedReportedCommentsURL = commentURL + "/GetApprovedReportedComments/userID="; // + {userID}, ako se za userID prosledi 0 vraca listu CommentInfo, u suprotnom samo komentare odredjenog

String saveOrUnsavePost = postURL + "/SaveOrUnsave"; // POST metoda, salje se SavedPost
String getSavedPosts = postURL + "/GetSavedPosts/userID="; // + {userID}, GET metoda, vraca PostInfo listu

String getMostImportantPostByUsesID = postURL + "/GetMostImportantPostByUsesID"; // + /userID={userID}/typeID={typeID}
String getReportedPostsByUserID = postURL + "/GetReportedPostsByUserID/userID="; // + {userID}

String changeAdminURL = adminURL + "/ChangeInfo";

//-------------------------------------- INSTITUTIONS ---------------------------------------
String institutionsURL = userDataURL + "/institutions";
String institutionsFromCityURL = userDataURL + "/institutions"; // + /city/{cityID}/category/{categoryID}/verificated/  - ukoliko zelite bez kategorije slati 0
String verificationURL = institutionsURL + "/verification/id=";
String getPostsForInstitutionURL = postURL + "/getPostsForInstitution/institutionID="; // + {institutionID}
String institutionFollowCategoryURL = categoryURL + "/FollowCategories/username=";
String notVerifiedInstitutionsURL = userDataURL + "/NotVerifiedInstitutions";
//---------------------------------- END OF INSTITUTIONS ------------------------------------

//-------------------------------------- SPONSORS ---------------------------------------
String addSponsorURL = adminURL + "/addSponsor"; // POST metoda, salje se sponsor, vraca true/false
String deleteSponsorURL = adminURL + "/deleteSponsor/sponsorID="; // + {sponsorID}, GET metoda, vraca true/false
String getAllSponsorsURL = adminURL + "/GetAllSponsors"; //vraca listu sponsor
String getSponsorURL = adminURL + "/GetSponsor/sponsorID="; // + {sponsorID}
String changeSponsorInformation = adminURL + "/ChangeSponsorInformation"; // POST metoda, salje se Sponsor
//---------------------------------- END OF SPONSORS ------------------------------------

//-------------------------------------- STATISTICS ---------------------------------------
String getCategoryStatistics = adminURL + "/GetCategoryStatistics"; // vraca listu categoryStatistic
String getUserStatisticsURL = userDataURL + "/GetUserStatistics"; // + /cityID={cityID}/byDay={byDay}/byMonth={byMonth}/byYear={byYear} - pitati Smigija kako
//---------------------------------- END OF STATISTICS ------------------------------------

//----------------------------- NOTIFICATIONS --------------------------------
String notificationURL = url + "/Notifications";
String getAllReadNotificationsURL =
    notificationURL + "/AllReadNotifications/"; // +{id} - oznacava UserID
String getAllNotReadNotificationsURL =
    notificationURL + "/AllNotReadNotifications/"; // + {id} - oznacava UserID
String getFirstNReadNotificationsURL =
    notificationURL + "/FirstN_ReadNotifications/"; // +{id} - oznacava UserID
String changeNotificationToReadURL = notificationURL +
    "/ChangeToRead"; // POST metoda + salje se notificationInfo
String readAllNotificationsURL =
    notificationURL + "/ReadAll/userID="; // + {userID}
//-------------------------- END OF NOTIFICATIONS ------------------------------

//-------------------------------------- MESSAGES ------------------------------------
String sendMessage = userDataURL + "/SendMessage";	// POST metoda, salje se Message 
String deleteMessage = userDataURL + "/DeleteMessage/messageID=";	// + {messageID}
String getAllUsersYouChattedWith = userDataURL + "/GetAllUsersYouChattedWith/userID="; // + {userID}, vraca UserData listu cetova
String getAllMessages = userDataURL + "/GetAllMessages"; // + user1ID={user1ID}/user2ID={user2ID}/numberOfMessages={numberOfMessages}
						//user1ID je logovan korisnik, user2ID je neko sa kim cetuje, numberOfMessages je broj poruka koji ce se vratiti, da ne vraca sve uvek
String getNumberOfUnreadMessages = userDataURL + "/GetNumberOfUnreadMessages"; // + user1ID={user1ID}/user2ID={user2ID}
						//ukoliko se za user2ID posalje 0 vraca se ukupan broj neprocitanih poruka iz svih cetova, a ukoliko se posalje odredjeni user2ID samo za taj cet
String readMessages = userDataURL + "/ReadMessages"; // + /user1ID={user1ID}/user2ID={user2ID}
						//sve neprocitane poruke iz odredjenog ceta se procitaju
//---------------------------------- END OF MESSAGES ------------------------------------


String checkIfSavedURL = postURL + "/CheckIfSaved"; // + /UserID={userID}/PostID={postID} - false nije sacuvan, true jeste sacuvan post
String newnew = userDataURL + "/institutions/city/";//{cityID}/category/{categoryID}"

