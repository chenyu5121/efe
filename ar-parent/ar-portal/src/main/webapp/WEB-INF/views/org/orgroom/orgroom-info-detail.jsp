<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/views/portal-common/portal-tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${orgroom.originName}-信电校友录</title>
<%@ include file="/WEB-INF/views/portal-common/portal-meta.jsp"%>
</head>
<body>

	<%@ include file="/WEB-INF/views/portal-common/header.jsp"%>

	<div class="container higher" id="container">
		<%@ include
			file="/WEB-INF/views/org/orgroom/orgroom-pageheader.jsp"%>
		<div class="mb5"></div>
		<!-- nav tab -->
		<%@ include file="/WEB-INF/views/org/orgroom/orgroom-nav.jsp"%>

		<!-- Tab panes -->
		<div class="tab-content" style="background-color: #ddd;">
			<div class="tab-pane active" id="classroom-content">
				<div class="row blog-content">
					<div class="col-sm-9">
						<div class="panel panel-default panel-blog">
							<div class="panel-body">
								<h3 class="blogsingle-title">${info.infoTitle}</h3>
								<ul class="blog-meta">
									<li>作者: <a href="ta/show.action?${info.userId}">${info.trueName}</a></li>
									<li><fmt:formatDate value="${info.createTime}" pattern="Y-M-d HH:mm"></fmt:formatDate></li>
									<li><i class="fa fa-eye"></i> 浏览 ${info.views} </li>
									<li><i class="fa fa-heart"></i> 喜欢 <span class="info-loves">${info.loves}</span></li>
									<li><i class="glyphicon glyphicon-comment"></i> 评论 ${info.comments}</li>
								</ul>
								<c:if test="${info.thumbImage!=null && info.thumbImage!=''}">
									<br/>
									<div class="blog-img">
										<img src="${info.thumbImage}" class="img-responsive"/>
									</div>
								</c:if>
								<br />
								<div class="blog-img"><img src="assets/images/photos/blog1.jpg" class="img-responsive" alt="" /></div>
								<div class="mb10"></div>
								${info.content} <br>
								<div class="mb10"></div>
								<p hidden id="infoId">${info.infoId}</p>
								<div class="widget-photoday">
									<ul class="photo-meta">
										<li><span><i class="fa fa-eye"></i> 浏览 (${info.views})</span></li>
										<li><a href="javascript:;" onclick="loveInfo(${info.infoId})" id="info-love-add">
											<i class="fa fa-heart"></i> 喜欢 (<arp class="info-loves">${info.loves}</arp>)</a>
										</li>
										<li><a href="javascript:;" onclick="focusCommentInfo()"><i class="fa fa-comment"></i> 评论 (${info.comments})</a></li>
										<c:if test="${info.userId == SESSION_USER.userId}" >
											<li><a href="javascript:;" onclick="deleteInfo(${info.infoId})"><i class="fa fa-trash-o"></i> 删除 </a></li>
										</c:if>
									</ul>
								</div>
							</div>
							<!-- panel-body -->
						</div>
						<!-- panel -->

						<ol class="breadcrumb">
							<li class="active"><i class="fa fa-user"></i> 关于作者</li>
						</ol>
						<div class="media">
							<a class="pull-left" href="ta/show.action?userId=${info.userId}">
								<img class="thumbnail img-responsive center-block" src="${info.portrait}"  style="max-width: 65px"/>
							</a>
							<div class="media-body event-body">
								<h4 class="subtitle">${info.trueName}</h4>
								<p>${info.introduce}</p>
							</div>
						</div>
						<!-- media -->

						<%--comment-list 评论列表--%>
						<ol class="breadcrumb">
							<li class="active"><i class="fa fa-comments-o"></i> 所有评论(${info.comments})</li>
						</ol>
						<ul class="media-list comment-list" id="comment-list">
							<img class="center-block" src='assets/images/icon/loader.gif'>
						</ul><!-- comment-list -->

						<%--登录可评论--%>
						<c:if test="${SESSION_USER != null}">
							<div class="mb20"></div>
							<h5 class="subtitle mb5"><i class="fa fa-user"></i> ${SESSION_USER.trueName}：</h5>
							<div class="mb20"></div>
							<form method="post" action="orgroom/commentInfo.action" id="form-comment">
								<textarea name="content" maxlength="500" rows="5" class="form-control" id="comment-content"></textarea>
								<input hidden id="originId" name="infoId" value="${info.infoId}">
								<div class="mb10"></div>
								<button class="btn btn-primary" onclick="commentInfo()" type="button"><i class="fa fa-comment"></i> 发表评论</button>
							</form>
						</c:if>

					</div>
					<!-- col-sm-8 -->

					<div class="col-sm-3">
						<div class="blog-sidebar">

							<h5 class="subtitle">班级动态</h5>
							<p>班级动态是了解班级同学近况的窗口</p>

							<div class="mb30"></div>

							<h5 class="subtitle">班级相关动态：</h5>
							<c:choose>
								<c:when
									test="${classOtherInfo!=null && fn:length(classOtherInfo)>1}">
									<ul class="sidebar-list">
										<c:forEach items="${classOtherInfo}" var="classInfo">
											<c:if test="${classInfo.infoId!=info.infoId}">
												<li><a
													href="classroom/infoDetail.action?classId=${classroom.classId}&infoId=${classInfo.infoId}"><i
														class="fa fa-angle-right"></i> <ar:sub length="15"
															value="${classInfo.infoTitle}" /> </a></li>
											</c:if>
										</c:forEach>
									</ul>
								</c:when>
								<c:otherwise>
								没有更多！
								</c:otherwise>
							</c:choose>

							<div class="mb30"></div>

							<h5 class="subtitle">董亮亮的动态：</h5>
							<c:choose>
								<c:when
									test="${classMateOtherInfo!=null && fn:length(classMateOtherInfo)>1}">
									<ul class="sidebar-list">
										<c:forEach items="${classMateOtherInfo}" var="mateInfo">
											<c:if test="${mateInfo.infoId!=info.infoId}">
												<li><a
													href="classroom/infoDetail.action?classId=${classroom.classId}&infoId=${mateInfo.infoId}"><i
														class="fa fa-angle-right"></i> <ar:sub length="15"
															value="${mateInfo.infoTitle}" /> </a></li>
											</c:if>
										</c:forEach>
									</ul>
								</c:when>
								<c:otherwise>
								没有更多！
								</c:otherwise>
							</c:choose>

						</div>
						<!-- blog-sidebar -->

					</div>
					<!-- col-sm-4 -->

				</div>
				<!-- row -->
			</div>
		</div>
		<!-- Tab panes -->
	</div>
	<!-- container -->

	<%@ include file="/WEB-INF/views/portal-common/footer.jsp"%>

</body>
<%@ include file="/WEB-INF/views/portal-common/portal-js.jsp"%>
<script src="assets/script/org/orgroom/orgroom-info-detail.js"></script>
</html>