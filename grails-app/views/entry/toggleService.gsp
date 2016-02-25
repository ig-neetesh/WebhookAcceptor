<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
</head>

<body>
<h2>Create a service Url :</h2>
<fieldset>
    <legend>Create new Url</legend>
    <select id="serviceFor">
        <option value="AGR">Agreement</option>
        <option value="PDF">Dynamic Pdf</option>
        <option value="COM">Company</option>
    </select>
    <input type="text" id="service" placeholder="service name">
    <input type="button" id="create" value="Create">
    <br/>

    <h2 id="serviceUrl"></h2>
</fieldset>
<hr/>

<h2>Disable a service Url with name :</h2>
<fieldset>
    <legend>Disable a service Url with name : </legend>
    <g:form action="toggleService">
        <input type="text" name="name" placeholder="service name">
        <input type="hidden" name="status" value="false">
        <input type="submit">
    </g:form>
</fieldset>
<hr/>

<h2>Disabled service Url names :</h2>
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${disabledServices}" var="s">
        <g:if test="${s}">
            <tr>
                <td>${s}</td>
                <td><g:link action="toggleService" params="[name: s, status: true]">Enable</g:link></td>
            </tr>
        </g:if>
    </g:each>
    </tbody>
</table>


<script type="text/javascript">
    $(document).ready(function () {
        var url = window.location.href;
        var hook = "/hook/";
        $("#create").click(function () {
            url = url.substring(0, url.indexOf(hook)) + hook + $("#serviceFor").val() + "_" + $("#service").val();
            $("#serviceUrl").html(url);
        });
    });
</script>
</body>
</html>