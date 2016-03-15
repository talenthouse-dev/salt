standup-reminder:
  cron.present:
    - name: "curl -X POST --data-urlencode 'payload={\"channel\": \"#engineers\", \"username\": \"ReminderBot\", \"text\": \"Daily standup now <https://plus.google.com/hangouts/_/talenthouse.com/eng-daily>\", \"icon_emoji\": \":goberserk:\"}' https://hooks.slack.com/services/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"
    - hour: 9
    - minute: 58
    - dayweek: 1,2,3,4,5
