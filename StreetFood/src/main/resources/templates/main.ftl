<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form method="get" action="/main" class="form-inline">
                <input type="text" name="filter" class="form-control" value="${filter?ifExists}" placeholder="Искать по тегу">

                <button type="submit" class="btn btn-primary ml-2">Искать</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Добавить новый отзыв
    </a>
    <div class="collapse" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control" name="text" placeholder="Введите сообщение"/>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="tag" placeholder="Тег"/>
                </div>

                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Добавить</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list messages as message>
            <div class="card my-3">
                <div class="card-body m-2">
                    <div>
                        <#if message.filename??>
                            <img class="card-img-top" src="/img/${message.filename}" alt="Card image cap">
                        </#if>
                    </div>
                    <span>${message.text}</span>
                    <div class="mt-2">
                        <i>#${message.tag}</i>
                    </div>
                </div>


                <div class="card-footer text-muted">
                    ${message.authorName}

                    <div>
                            <#if user.id == message.getAuthor().id>
                                <a href="/edit/${message.id}" class="btn btn-primary">Редактировать</a>
                            </#if>

                            <#if user.id == message.getAuthor().id>
                                <a href="/delete/${message.id}" class="btn btn-secondary">Удалить</a>
                            </#if>

                    </div>
                    <div >
                        <#if isAdmin>
                            <span> Администратор:</span>
                            <div>
                                <a href="/delete/${message.id}" class="btn btn-info">Удалить</a>
                            </div>

                        </#if>
                    </div>
                </div>


            </div>
        <#else>
            Нет отзывов
        </#list>
    </div>
</@c.page>