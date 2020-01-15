<#import "parts/common.ftl" as c>

<@c.page>
    Редактор отзыва
    <form action="/save" method="post">
        <input type="text" class="form-control" value="${message.text}" name="text" placeholder="Введите сообщение"/>
        <input type="text" class="form-control" value="${message.tag}" name="tag" placeholder="Тег"/>
        <input type="hidden" value="${message.id}" name="messageId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit">Сохранить отзыв</button>
    </form>
</@c.page>