import { idbKeyval } from 'indexdb'

idbKeyval.get("push-subscriber").then(push => {
  $("#campaign_push_id").val(push)
})
