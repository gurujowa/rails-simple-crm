jQuery ->

  if(0 < $(".period_editable").size())
    $(".period_editable").editable
      method: "POST"
      url: "/periods/update"

  if(0 < $(".period_resume_editable").size())
    $(".period_resume_editable").editable
      url: "/periods/update"
      type: "select"
      method: "POST"
      source: [
        {value: "notstart", text: "未着手"}
        {value: "complete", text: "完了"}
      ]
