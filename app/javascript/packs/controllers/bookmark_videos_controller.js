import { Controller } from 'stimulus'

export default class extends Controller {
	static targets = [ "user_id", "video_id" ]

	// alreadyBookmarked = (data, videoId, userId) => {
	// 	if (data.video_id === parseInt(videoId) && data.user_id === parseInt(userId)) {
	// 		alert("Already Bookmarked")
	// 	} else {
	// 		alert("Bookmarked!")
	// 	}
	// }

	newBookmark = event => {
	event.preventDefault();
	const videoId = event.target.getAttribute("video_id")
	const userId = event.target.getAttribute("user_id")
		fetch("/api/v1/bookmarks", {
			method: "POST",
			headers: {
			  "Content-Type": "application/json; charset=utf-8",
			},
			body: JSON.stringify({"user_id":event.target.getAttribute("user_id"), "video_id":event.target.getAttribute("video_id")})
			})
			.then(response => response.json())
			.then (data => data)
			.catch(error => console.error(error))
			alert("Bookmarked!");
			}
	  }
