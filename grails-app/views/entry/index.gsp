<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Hooks</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <style>
    .btn {
        border: 1px solid #cccccc;
        display: inline-block;
        margin: 5px;
        padding: 5px;
        width: auto;
        color: #FF002B;
    }

    #pre {
        display: none;
        border-left: 10px solid #999999;
        background-color: #dddddd;
        width: 300px;
        padding: 10px;
        position: absolute;
        right: 20px;
        top: 20px;
    }

    .btn:hover {
        background-color: #FF002B;
        color: #ffffff;
    }

    li {
        list-style: none;
        height: 30px;
        border: 1px solid #cccccc;
        background-color: #dddddd;
        padding-right: 15px;
    }

    th {
        border-right: 1px solid #cccccc;
    }

    .col-m {
        width: 150px;
    }

    .col-s {
        width: 100px;
    }

    a {
        text-decoration: none;
    }

    .selected {
        background-color: #ffffff;
        border-right-color: #ffffff;
    }

    .right-td {
        vertical-align: top;
    }

    .pane {
        height: 500px;
    }

    .leftPane {
        overflow-y: auto;
        overflow-x: hidden;
        direction: rtl;
    }

    .leftPane ul {
        margin: 0 -40px 0 0;
    }

    .rightPane {
        overflow-x: scroll;
        overflow-x: hidden;
    }

    table.main {
        border: 1px solid #000000;
    }

    table.main thead {
        background-color: #000000;
        color: #cccccc;
    }

    .col-b {
        border-bottom: 1px solid #cccccc;
        padding: 5px;
    }

    </style>
</head>

<body>
<g:if test="${selected}">
    <p>Selected : <b>${selected}</b></p>
</g:if>
<g:if test="${names}">
    <g:link class="btn" action="clear">Delete all</g:link>
</g:if>
<g:if test="${selected}">
    <g:link class="btn" action="clear" params="[name: selected]">Delete from <b>${selected}</b></g:link>
</g:if>

<table class="main" cellpadding="0" cellspacing="0">
    <thead>
    <tr>
        <th class="col-m">Name</th>
        <th class="col-m">eventTimestamp</th>
        <th class="col-m">referenceId</th>
        <th class="col-m">status</th>
        <th class="col-m">templateId</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
            <div class="pane leftPane">
                <ul>
                    <g:each in="${names}" var="name">
                        <li ${selected == name ? "class=selected" : ""}>
                            <g:link id="${name}" params="[name: name]">${name}</g:link>
                        </li>
                    </g:each>
                </ul>
            </div>
        </td>
        <td colspan="4" class="right-td">
            <div class="pane rightPane">
                <table cellpadding="0" cellspacing="0">
                    <tbody>
                    <g:each in="${values}" var="hook">
                        <tr>
                            <td class="col-m col-b">${new Date(hook.eventTimestamp.toLong()).format("MMM dd, yyyy HH:mm")}</td>
                            <td class="col-m col-b">${hook.referenceId}</td>
                            <td class="col-m col-b">${hook.status}</td>
                            <td class="col-m col-b">${hook.templateId}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </td>
    </tr>
    </tbody>
</table>
<input type="hidden" id="n" value="${names.size()}">
<input type="hidden" id="v" value="${total}">
<pre id="pre">
    Hey! Some new event has arrived.
    Here are the details:
    New webhook requests : <b id="names">0</b>
    New Events : <b id="values">0</b>
    Please <a style="border: 2px solid #999999;" href="javascript:history.go(0)">Refresh</a> for fresh data.
</pre>
<script type="text/javascript">
    $(document).ready(function () {
        setInterval(function () {
            $.ajax({
                url: "${g.createLink(action: 'status')}",
                data: {
                    n: $("#n").val(),
                    v: $("#v").val()
                },
                context: document.body
            }).done(function (data) {
                console.log(data);
                if (data.names || data.values) {
                    $("#pre").show();
                    $("#names").html(data.names);
                    $("#values").html(data.values);
                }
            });
        }, 3000);
    });
</script>
</body>
</html>