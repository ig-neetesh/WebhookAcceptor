class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'entry', action: 'index')
        "500"(view: '/error')
        "/$name"(controller: 'entry', action: 'store')
    }
}
