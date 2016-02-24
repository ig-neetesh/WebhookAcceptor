package webhookacceptor

import com.ttnd.HookInfo

class EntryService {

    static Map<String, List<HookInfo>> map = [:].withDefault { [] }

    void store(String name, HookInfo hook) {
        map.get(name) << hook
    }

    void clear(String name) {
        if (name) {
            map.get(name).clear()
        } else {
            map.clear()
        }
    }

    Map status(int n, int v) {
        Map result = [
                names : 0,
                values: 0
        ]
        if (map) {
            Map m = map.findAll {it.key}
            result.names = (m.keySet().size() - n)
            result.values = (m.values().flatten().size() - v)
        }
        return result
    }

}
