//String url = 'http://10.0.2.2:58482/api';
// String url = 'http://192.168.0.106:45455/api';
 String url = 'http://147.91.204.116:2033/api';
String urlImageUploadProfilePhoto = "http://147.91.204.116:2033/api/ImageUpload/ProfilePhoto";
String urlImageUpload = "http://147.91.204.116:2033/api/ImageUpload";
String categoryURL = url + "/Categories";
String cityURL = url + "/Cities";
String postURL = url + "/Posts";
String typeURL = url + "/Types";
String userDataURL = url + "/UserDatas";
String loginURL = userDataURL + "/login";
String emailURL = userDataURL + "/email";
String usernameURL = userDataURL + "/username";
String commentURL = url + "/Comments";
String commentDislikeURL = url + "/CommentDislikes";
String commentLikeURL = url + "/CommentLikes";
String notificationURL = url + "/Notifications";
String notificationLiveURL = "http://147.91.204.116:2033/livenotification";
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
String followURL = url + "/Follows";
String postReactionURL = url + "/PostReactions/NewPostReaction";
String postReportURL = url + "/PostReports";
String userReportURL = url + "/UserReports";
String changeUserInfoURL = userDataURL + "/ChangeInfo";
String wwwrootURL = "http://147.91.204.116:2033//";
String changePostInfoURL = postURL + "/ChangePostInfo";
String getpostReactionURL = url + "/GetPostReaction";
//String wwwrootURL = "http://192.168.0.106:45455//";
String commentReactionURL = url + "/CommentReactions";
String newCommentReactionURL = commentReactionURL + "/NewCommentReaction";
String getAllFollowingUsersURL = followURL + "/user"; // + {UserID}
String getAllFollowersOfUserURL =
    followURL + "/whoIsFollowingUser"; // + /{UserId}
String getAllPostsOfUserThatYouFollowURL =
    followURL + "/GetPostOfFollowersByUserID"; // + /{UserId}
String checkIfFollowURL =
    followURL + "/IsThereAFollow"; // + /{userFollowID}/{followingUserID}
String getUsersThatReactedOnPost =
    userDataURL + "/GetUsersThatReacted/post"; // + /{postID}
String getUsersThatLikedCommentURL =
    userDataURL + "/GetUsersThatLiked/comment"; //+ // + /{commentID}
String getUsersThatDislikedCommentURL =
    userDataURL + "/GetUsersThatDisliked/comment"; //+ // + /{commentID}
String citizensURL = userDataURL + "/citizens"; // + /userId={userID}
String citizensFromCity =
    userDataURL + "/citizens"; // + /cityID={cityID}/userId={userID}
String institutionsURL = userDataURL + "/institutions";
String institutionsFromCityURL = userDataURL +
    "/institutions"; // + /city/{cityID}/category/{categoryID} !!! IZMENJEN URL !!! dodati za odredjenu kategoriju, ukoliko zelite bez kategorije slati 0
String logoutURL = userDataURL + "/logout";
String addChallengeSolutionURL =
    postURL + "/AddChallengeSolution/ChallengeID="; // +/{challengeID}
String getChallengeOrSolutionURL = postURL +
    "/GetChallengeOrSolution"; // + /postID={postID}/IsApproved={IsApproved}
String checkRangURL =
    userDataURL + "/CheckRang/userID="; // + {userID} GET metoda
String getBestUsersURL = userDataURL +
    "/GetBest"; // + /userTypeID={userTypeID}/days={days}/userNumber={userNumber}
String getPointsUserURL =
    userDataURL + "/GetPointsForUser"; // + /userID={userID}/days={days}
String closeChallengeURL =
    postURL + "/CloseChallenge/challengeID="; // +{challengeID} POST metoda
String solutionRejectedURL = postURL +
    "/ChallengeRejected"; // + /challengeID={challengeID}/solutionID={solutionID} POST metoda
String isSolutionApprovedURL =
    postURL + "/IsSolutionApproved/solutionID="; // +{solutionID}
String getPostsForInstitution =
    postURL + "/getPostsForInstitution"; // + /institutionID={institutionID}

String getFilteredPostsURL = postURL +
    "/getFilteredPosts"; // + /UserID={UserID}/cityID={cityID}/fromFollowers={fromFollowers}/activeChallenge={activeChallenge}/sortByReactions={sortByReactions}
// fromFollowers 0 uzima sve postove a 1 uzima samo postove ljudi koje prati, activeChallenge 0 uzima sve postove a 1 uzima samo postove koji su aktivni izazovi
// sortByReactions 0 sortira postove po vremenu a 1 sortira postove po broju reakcija ---- POST metoda, pored prosledjenog URLa treba proslediti u body-u listu kategorija ili prazan niz

String commentsWithDislikesURL =
    commentURL + "/commentsWithDislikes"; // + /userID={userID}

String getUserPostsFilteredByType = postURL +
    "/UserPostsFilteredByType"; // + /userID={userID}/typeID={typeID}/ - typeID 1 otvoren izazov, 2 resenje, 3 zavrsen izazov
String getFollowSugestionsURL =
    userDataURL + "/followSugestions/userId="; // + {userID}
String getMostImportantPosts =
    postURL + "/GetMostImportantPost/"; // + cityID={cityID}/typeID={typeID}

String adminURL = url + "/Admins";
String getAllSponsorsURL = adminURL + "/GetAllSponsors"; //vraca listu sponsor
String getSponsorURL = adminURL + "/GetSponsor/sponsorID="; // + {sponsorID}

String saveOrUnsavePost =
    postURL + "/SaveOrUnsave"; // POST metoda, salje se SavedPost
String getSavedPosts = postURL +
    "/GetSavedPosts/userID="; // + {userID}, GET metoda, vraca PostInfo listu

//-------------------------------------- MESSAGES ------------------------------------
String sendMessage =
    userDataURL + "/SendMessage"; // POST metoda, salje se Message
String deleteMessage =
    userDataURL + "/DeleteMessage/messageID="; // + {messageID}
String getAllUsersYouChattedWith = userDataURL +
    "/GetAllUsersYouChattedWith/userID="; // + {userID}, vraca UserData listu cetova
String getAllMessages = userDataURL +
    "/GetAllMessages"; // + user1ID={user1ID}/user2ID={user2ID}/numberOfMessages={numberOfMessages}
//user1ID je logovan korisnik, user2ID je neko sa kim cetuje, numberOfMessages je broj poruka koji ce se vratiti, da ne vraca sve uvek
String getNumberOfUnreadMessages = userDataURL +
    "/GetNumberOfUnreadMessages"; // + user1ID={user1ID}/user2ID={user2ID}
//ukoliko se za user2ID posalje 0 vraca se ukupan broj neprocitanih poruka iz svih cetova, a ukoliko se posalje odredjeni user2ID samo za taj cet
String readMessages =
    userDataURL + "/ReadMessages"; // + /user1ID={user1ID}/user2ID={user2ID}
//sve neprocitane poruke iz odredjenog ceta se procitaju
//---------------------------------- END OF MESSAGES ------------------------------------


String checkIfSavedURL = postURL + "/CheckIfSaved"; // + /UserID={userID}/PostID={postID} - false nije sacuvan, true jeste sacuvan post

String forgottenPasswordURL = userDataURL + "/forgottenPassword";

