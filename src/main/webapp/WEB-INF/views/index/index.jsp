<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.hidden-xs {
	white-space: nowrap;
	overflow: hidden;
}

.widget-posts-title {
	margin-top: 10px;
}
</style>
<script type="text/javascript">
window.onload = function() {
	$.ajax({
		url : '${contextPath}/informations/indexCity',
		success : function (data) {
		var html = '<div class="post-thumbnail" id="preView">';
			html += '<img src="${contextPath}/resources/upload/admin/information/City/'+data[0].cityImage+'" alt="Blog Featured Image" />';
		 	html += '</div><div class="post-header font-alt">';
			html += '<h1 class="post-title">'+data[0].cityName+'</h1>';
			html += '<div class="post-meta"><p>'+data[0].cityExp+'</p></div></div>';
			$('#baseinfo').append(html);
			setTimeout(function () {
		 	for(var i = 0 ; i < data.length ; i++){
		 		var Xpoint =data[i].divingXpoint;
		 		var Ypoint = data[i].divingYpoint;
		 		var DivingName = data[i].divingName;
		 		var DivingRating = data[i].divingRating;
		 		var DivingDepthMin = data[i].divingDepthMin;
		 		var DivingDepthMax = data[i].divingDepthMax;

		 		var img = document.createElement("img");
		 		img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
				img.setAttribute("class","pointChecker");
				img.setAttribute("onclick","location.href='${contextPath}/DivingSiteView.info?CityName="+data[0].cityName+"&DivingName="+DivingName+"'");
				img.setAttribute("cursor","pointer");
				img.style.position="absolute";
		 		img.style.width="15px";
		 		img.style.height="15px";
		 		img.setAttribute("title",DivingName+"\n단계 :"+DivingRating+"\n수심 : "+DivingDepthMin+"m ~ "+DivingDepthMax+"m");
		 		img.style.left = Xpoint * $('#preView>img').width()+8 + "px";
		 		img.style.top = Ypoint * $('#preView>img').height()-7 + "px";
		 		document.getElementById('preView').appendChild(img);
		 		}
			},100);
				$(window).resize(function() {
					$('.pointChecker').remove();
				 	for(var i = 0 ; i < data.length ; i++){
				 		var Xpoint =data[i].divingXpoint;
				 		var Ypoint = data[i].divingYpoint;
				 		var DivingName = data[i].divingName;
				 		var DivingRating = data[i].divingRating;
				 		var DivingDepthMin = data[i].divingDepthMin;
				 		var DivingDepthMax = data[i].divingDepthMax;

				 		var img = document.createElement("img");
				 		img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
						img.setAttribute("class","pointChecker");
						img.setAttribute("onclick","location.href='${contextPath}/DivingSiteView.info?CityName="+data[0].cityName+"&DivingName="+DivingName+"'");
						img.setAttribute("cursor","pointer");
						img.style.position="absolute";
				 		img.style.width="15px";
				 		img.style.height="15px";
				 		img.setAttribute("title",DivingName+"\n단계 :"+DivingRating+"\n수심 : "+DivingDepthMin+"m ~ "+DivingDepthMax+"m");
				 		img.style.left = Xpoint * $('#preView>img').width()+8 + "px";
				 		img.style.top = Ypoint * $('#preView>img').height()-7 + "px";
				 		document.getElementById('preView').appendChild(img);
				 		}
				});
				$.ajax({
					url:'${contextPath}/informations/getIndexCityResortList',
					type : 'POST',
					data : {CityName : data[0].cityName},
					success : function(data2) {
					    var html = "";
					    for (var i = 0; i < data2.length; i++) {
							html += '<li class="clearfix">';
							html +='<div class="widget-posts-image">';
							html +='<a href="#"><img src="${contextPath}/resources/images/Resort/thumbnail/'+data2[i].num+'/'+data2[i].image1+'"/></a>';
							html +='</div><div class="widget-posts-body"><div class="widget-posts-title">';
							html +='<a href="${contextPath}/Resort/moveViewResort?num='+data2[i].num+'">'+data2[i].resortName+'</a></div></div></li>';	
						}
					    $('#aroundResort').append(html);
					}
				});
				
		}
	});
}
</script>
</head>
<body>
	<!-- 이미지 -->
	<section class="module">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3" style="margin-left: 10%">
					<div class="module-subtitle font-serif"
						style="margin-bottom: 20px; float: left;">후기 사진</div>
				</div>
			</div>
			<div class="row">
				<div class="owl-carousel text-center" data-items="5"
					data-pagination="false" data-navigation="false">
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-1.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-3.jpg"
									alt="Derby shoes" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Derby shoes</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-2.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-4.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-5.jpg"
									alt="Chelsea boots" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Chelsea boots</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-6.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--   두번쨰이미지 -->
		<div class="container" style="margin-top: 15px;">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3" style="margin-left: 10%">
					<div class="module-subtitle font-serif"
						style="margin-bottom: 20px; float: left;">수중 사진</div>
				</div>
			</div>
			<div class="row">
				<div class="owl-carousel text-center" data-items="5"
					data-pagination="false" data-navigation="false">
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-1.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-3.jpg"
									alt="Derby shoes" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Derby shoes</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-2.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-4.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-5.jpg"
									alt="Chelsea boots" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Chelsea boots</a>
								</h4>
							</div>
						</div>
					</div>
					<div class="owl-item">
						<div class="col-sm-12">
							<div class="ex-product">
								<a href="#"><img src="${contextPath}/resources/assets/images/shop/product-6.jpg"
									alt="Leather belt" /></a>
								<h4 class="shop-item-title font-alt">
									<a href="#">Leather belt</a>
								</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 이미지 -->
	<!-- 정보 공유 -->
	<section class="module-small" style="padding: 0;">
		<div class="container">
			<div class="row">
				<div class="col-sm-8">
					<div class="post" id="baseinfo">
					</div>
				</div>
				<!--위쪽 이미지 // 아래쪽 사이드바 -->
				<div class="col-sm-4 col-md-3 col-md-offset-1 sidebar">
					<div class="widget">
						<h5 class="widget-title font-alt">근처 리조트 정보</h5>
						<ul class="widget-posts" id="aroundResort">
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 정보 공유 -->
	<!-- 커뮤니티 -->
	<section class="module" style="padding: 0;">
		<div class="container">
			<div class="row multi-columns-row post-columns">
				<div class="col-sm-6 col-md-3 col-lg-3">
					<div class="post">
						<div class="post-header font-alt">
							<h2 class="post-title">
								<a href="#">커뮤니티 1</a>
							</h2>
						</div>
						<div class="post-entry">
							<table class="table table-striped table-border checkout-table">
								<tbody>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="post-more">
							<a class="more-link" href="#">Read more</a>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-3 col-lg-3">
					<div class="post">
						<div class="post-header font-alt">
							<h2 class="post-title">
								<a href="#">커뮤니티 2</a>
							</h2>
						</div>
						<div class="post-entry">
							<table class="table table-striped table-border checkout-table">
								<tbody>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="post-more">
							<a class="more-link" href="#">Read more</a>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-3 col-lg-3">
					<div class="post">
						<div class="post-header font-alt">
							<h2 class="post-title">
								<a href="#">커뮤니티 3</a>
							</h2>
						</div>
						<div class="post-entry">
							<table class="table table-striped table-border checkout-table">
								<tbody>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="post-more">
							<a class="more-link" href="#">Read more</a>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-3 col-lg-3">
					<div class="post">
						<div class="post-header font-alt">
							<h2 class="post-title">
								<a href="#">커뮤니티 4</a>
							</h2>
						</div>
						<div class="post-entry">
							<table class="table table-striped table-border checkout-table">
								<tbody>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
									<tr>
										<td><a href="#">제목 글</a></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="post-more">
							<a class="more-link" href="#">Read more</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 커뮤니티 -->
	<jsp:include page="../inc/Footer.jsp" />
</body>
</html>