$(function() {
	$('button#follow').click(function(e){
		$this = $(this);
		if($this.html().trim() == 'Follow'){
			$.ajax({
	          type : "POST",
	          url : "module_followings",
	          data:JSON.stringify({
	            mod_id: $this.data('mid'),
	            mod_follower_id: $this.data('uid'),
	          }),
	          contentType: 'application/json',
	          success : function(response) {
	          	$this.html("Unfollow");
	            console.log("success");
	          },
	          error : function(response) {
	            console.log("not");
	          }
	        }); 
		}else{
			var mid = 	$this.data('mid');
			var url = "/nus_modules/" + mid.toString() + "/module_followings_delete";
			console.log("url = " + url);
			console.log(mid);
			$.ajax({
	          type : "POST",
	          url : url,
	          data:JSON.stringify({
	            mod_id: $this.data('mid'),
	            mod_follower_id: $this.data('uid'),
	          }),
	          contentType: 'application/json',
	          success : function(response) {
	          	$this.html("Follow");
	            console.log("success");
	          },
	          error : function(response) {
	            console.log("not");
	          }
	        }); 
		}
		
	})
})
