package webhookacceptor

import com.ttnd.HookInfo

class EntryService {

    static Map<String, List<HookInfo>> map = [:].withDefault { [] }

    static Set<String> disabledServices = [] as Set

    boolean store(String name, HookInfo hook) {
        if (disabledServices.contains(name)) {
            return false
        }
        map.get(name) << hook
        return true
    }

    Set<String> toggleService(String name, boolean toggle) {
        if (toggle) {
            if (disabledServices.contains(name)) {
                disabledServices.remove(name)
            }
        } else if (name) {
            disabledServices.add(name)
        }
        return disabledServices
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
            Map m = map.findAll { it.key }
            result.names = (m.keySet().size() - n)
            result.values = (m.values().flatten().size() - v)
        }
        return result
    }

}
