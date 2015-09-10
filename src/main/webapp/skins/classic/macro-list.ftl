<#macro list listData>
<div class="article-list list">
    <ul>
        <#assign articleIds = "">
        <#list listData as article>
        <#assign articleIds = articleIds + article.oId>
        <#if article_has_next><#assign articleIds = articleIds + ","></#if>
        <li>
            <div class="fn-flex">
                <a rel="nofollow" class="ft-gray"
                   href="/member/${article.articleAuthorName}" 
                   title="${article.articleAuthorName}"><img class="avatar" src="${article.articleAuthorThumbnailURL}-64.jpg?${article.articleAuthor.userUpdateTime?c}" /></a>
                <div class="fn-flex-1 has-view">
                    <h2>
                        <#if article.articleType == 1>
                        <span class="icon-locked" title="${discussionLabel}"></span>
                        <#elseif article.articleType == 2>
                        <span class="icon-feed" title="${cityBroadcastLabel}"></span>
                        </#if>
                        <a data-id="${article.oId}" rel="bookmark" href="${article.articlePermalink}">${article.articleTitleEmoj}</a>
                    </h2>
                    <#list article.articleTags?split(",") as articleTag>
                    <a rel="tag" class="tag" href="/tags/${articleTag?url('UTF-8')}">${articleTag}</a>
                    </#list>
                    <span class="ft-fade">&nbsp;•&nbsp;${article.timeAgo}</span>
                </div>
            </div>
            <#if article.articleCommentCount != 0>
            <div class="cmts" title="${cmtLabel}">
                <a class="count ft-gray" href="${article.articlePermalink}">${article.articleCommentCount}</a>
            </div>
            </#if>
            <div class="commenters">
                <#list article.articleParticipants as comment>
                <a rel="nofollow" href="${article.articlePermalink}#${comment.commentId}" title="${comment.articleParticipantName}">
                    <img class="avatar-small" src="${comment.articleParticipantThumbnailURL}-64.jpg?${comment.articleParticipantThumbnailUpdateTime?c}" />
                </a>
                </#list>
            </div>
            <i class="heat" style="width:${article.articleHeat*3}px"></i>
        </li>
        </#list>
    </ul>
</div>

<script type="text/javascript" src="${staticServePath}/js/lib/ws-flash/swfobject.js"></script>
<script type="text/javascript" src="${staticServePath}/js/lib/ws-flash/web_socket.js"></script>
<script type="text/javascript" src="${staticServePath}/js/lib/reconnecting-websocket.min.js"></script>
<script type="text/javascript" src="${staticServePath}/js/channel${miniPostfix}.js?${staticResourceVersion}"></script>
<script>
    WEB_SOCKET_SWF_LOCATION = "${staticServePath}/js/lib/ws-flash/WebSocketMain.swf";

    // Init [Article List] channel
    ArticleListChannel.init("ws://${serverHost}:${serverPort}/article-list-channel?articleIds=${articleIds}");
</script>
</#macro>