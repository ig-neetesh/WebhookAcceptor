package webhookacceptor

import com.ttnd.HookInfo
import grails.converters.JSON

class EntryController {
    def entryService

    def index(String name) {
        [selected: name, names: entryService.map.keySet().findAll {
            it
        }, values: entryService.map.get(name), total: entryService.map.values().flatten().size()]
    }

    def clear(String name) {
        entryService.clear(name)
        redirect action: 'index', params: [name: name]
    }

    def store(String name) {
        log.info "Hook event received"
        HookInfo hook = new HookInfo()
        bindData(hook, params)
        entryService.store(name, hook);
        response.setStatus(200)
        render "ok"
    }

    def status(int n, int v) {
        render entryService.status(n, v) as JSON
    }

}
