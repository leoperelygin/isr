<#include "security.ftl">
<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <div class="form-group">
            <label for="exampleInputEmail1">Имя пользователя</label>
            <input type="text" name="username" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Введите имя пользователя">
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Пароль</label>
            <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Введите пароль">
        </div>
        <#if !isRegisterForm>
            <a href="\registration"> Создать нового пользователя</a>
        </#if>
        <button type="submit" class="btn btn-primary">
            <#if isRegisterForm> Создать
            <#else> Войти
            </#if>
        </button>
    </form>
</#macro>

<#macro logout>
    <form action=/logout method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">
            <#if name != "Гость">
                Выйти
            <#else>
                Войти
            </#if>
        </button>
    </form>
</#macro>