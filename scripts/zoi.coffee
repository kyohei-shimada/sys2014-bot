# Description:
#   hubot show zoi images
#
# Commands:
#   hubot show zoi images when message contain word 'zoi'
#
#   zoi list:
#       Reply all words that hubot listening.
#
# Usage:
#
# Hubot> がんばるzoi
# Hubot> https://pbs.twimg.com/media/BspWaPYCAAAI6Ui.jpg:small
#
# Hubot> しんちょく zoi
# Hubot> https://pbs.twimg.com/media/Bsw1StjCQAA9NQ1.jpg:small
#
# # zoi add {word} {url}で記憶させられる
# Hubot> zoi add あいうえお some-image-url
# Hubot> あいうえおzoi
# Hubot> some-image-url
#
# # なお、1 wordにつき1 urlのみしか対応づけられない。
#
# zoi remove {word} で記憶を忘れさせられる
# Hubot> zoi remove あいうえお
#
# zoi update {word} { url} で記憶を更新させられる
# Hubot> zoi update あいうえお new-image-url
#
# # キーワードが存在しない or 空白の時はランダム
# Hubot> おやすみなさいzoi
# Hubot> https://pbs.twimg.com/media/BtcSRdRCMAArUCS.jpg:small
#
# Hubot> zoi
# Hubot> https://pbs.twimg.com/media/Bsw1StjCQAA9NQ1.jpg:small
#
# Hubot> zoi list
# Hubot> Shell: がんばる
# Hubot> Shell: あきらめる
# ...
# Hubot> Shell: やった
# Hubot> よし お仕事頑張るぞ!

module.exports = (robot) ->
    class Zoi
        constructor:(brain) ->
            @brain = if not brain then {} else brain
            @default =  {
                "がんばる":[
                    "https://pbs.twimg.com/media/BspTawrCEAAwQnP.jpg:small"
                    "https://pbs.twimg.com/media/BspTkipCIAE4a0n.jpg:small"
                    "https://pbs.twimg.com/media/BspWSkvCAAAMi43.jpg:small"
                    "https://pbs.twimg.com/media/BspWVoqCEAADtZ4.jpg:small"
                    "https://pbs.twimg.com/media/BspWaPYCAAAI6Ui.jpg:small"
                    "https://pbs.twimg.com/media/BswuTdaCQAAQCkg.jpg:small"
                ]
                "あきらめる":[
                    "https://pbs.twimg.com/media/BspWc7LCAAAPzhS.jpg:small"
                    "https://pbs.twimg.com/media/BspWfqoCYAE836J.jpg:small"
                    "https://pbs.twimg.com/media/BtcSLNRCMAAFGoH.jpg:small"
                    "https://pbs.twimg.com/media/BtcSIHmCUAA8Prp.jpg:small"
                ]
                "かえる":[
                    "https://pbs.twimg.com/media/BswuLr2CMAA1SpE.jpg:small"
                ]
                "きたく":[
                    "https://pbs.twimg.com/media/BtcSRdRCMAArUCS.jpg:small"
                ]
                "ごはん":[
                    "https://pbs.twimg.com/media/BspWlZFCMAA4fmV.jpg:small"
                    "https://pbs.twimg.com/media/BswuMrPCEAEECXg.jpg:small"
                    "https://pbs.twimg.com/media/BtcSOp6CcAA9_b4.jpg:small"
                    "https://pbs.twimg.com/media/BtcSFKpCQAAb73x.jpg:small"
                ]
                "ねる":[
                    "https://pbs.twimg.com/media/BspWoBQCcAAm9y5.jpg:small"
                    "https://pbs.twimg.com/media/BtcSM8BCYAE3_8j.jpg:small"
                ]
                "わかった":[
                    "https://pbs.twimg.com/media/BswuH1qCcAAueYw.jpg:small"
                ]
                "いけるきがする":[
                    "https://pbs.twimg.com/media/BswuNkICcAE4olR.jpg:small"
                ]
                "あせる":[
                    "https://pbs.twimg.com/media/BswuJviCYAMCdGc.png:small"
                ]
                "しんちょく":[
                    "https://pbs.twimg.com/media/Bsw1StjCQAA9NQ1.jpg:small"
                ]
                "きゅうけい":[
                    "https://pbs.twimg.com/media/BswuUTPCYAAVX5n.jpg:small"
                    "https://pbs.twimg.com/media/BtcSU0xCcAAmz_W.jpg:small"
                ]
                "おはよう":[
                    "https://pbs.twimg.com/media/Bs7qd4uCAAAwalT.jpg:small"
                    "https://pbs.twimg.com/media/Bts7OpFCcAEkaO4.jpg:small"
                ]
                "つかれた":[
                    "https://pbs.twimg.com/media/BtcSG05CMAEEyIG.jpg:small"
                ]
                "ありがとう":[
                    "https://pbs.twimg.com/media/BtcSDbWCQAADuhK.jpg:small"
                ]
                "やった":[
                    "https://pbs.twimg.com/media/Bts7BNsCMAASKsP.jpg:small"
                ]
            }

        find:(key) ->
            if @exist_default(key)
                return  @default[key][Math.floor(Math.random() * @default[key].length)]
            else if @exist(key)
                return @brain.data['zoi'][key]
            else
                return false

        exist_default:(key) ->
            if @default[key]
                return true
            return false

        exist:(key) ->
            if @brain.data['zoi'][key]
                return true
            return false

        add:(key, value) ->
            @exist(key)
            @exist_default(key)
            if @exist_default(key)
                return false
            else if @exist(key)
                return false
            else
                @brain.data['zoi'][key] = value
                @brain.save()
                return value

        delete:(key) ->
            if @exist_default(key)
                return false
            else
                delete @brain.data['zoi'][key]
                @brain.save()
                return key

        update:(key, value) ->
            if @exist_default(key)
                return false
            else
                @brain.data['zoi'][key] = value
                @brain.save()
                return value

        list_default: ->
            list = '\n'
            for key of @default
                list += key + '\n'
            return list

        list: ->
            return "" if not @brain.data['zoi']

            list = '\n'
            for key of @brain.data['zoi']
                list += "#{key}" + '\n'
            return list

        random: ->
            arr = []
            for key, urls of @default
                for url in urls
                    arr.push(url)
            for key, value of @brain.data['zoi']
                arr.push(value)
            return arr[Math.floor(Math.random() * arr.length)]

    robot.hear /^zoi list$/i, (msg) ->
        zoi = new Zoi(robot.brain)
        list = zoi.list_default()
        if robot.brain.data['zoi']
            list += '\n' + 'ここからはzoi add {word} {url}で追加したzoiです！'
            list += zoi.list()
        msg.reply list
        msg.send "よし お仕事頑張るぞ!"

    robot.hear /^zoi add (.*?)\s(.*?)$/, (msg) ->
        zoi = new Zoi(robot.brain)
        word = msg.match[1]
        image_url = msg.match[2]
        if zoi.exist_default(word)
            msg.reply "#{word} はデフォルトで登録されています！　変更したいときはhttps://github.com/malt03/sys2014-bot にプルリクエストしてください。"
        else if zoi.exist(word)
            msg.reply "#{word} はもう登録してあります。消したいときは zoi remove キーワード url してください。"
        else
            msg.reply "#{word} を登録しました！" if zoi.add(word, image_url)

    robot.hear /^zoi update (.*?)\s(.*?)$/, (msg) ->
        zoi = new Zoi(robot.brain)
        word = msg.match[1]
        image_url = msg.match[2]
        if zoi.exist_default(word)
            msg.reply "#{word} はデフォルトで登録されています！　変更したいときはhttps://github.com/malt03/sys2014-bot にプルリクエストしてください。"
        else if not zoi.exist(word)
            msg.reply "#{word} はまだ登録してませんよ？"
        else
            msg.reply "#{word} の登録を変更しました！" if zoi.update(word, image_url)

    robot.hear /^zoi remove (.*?)$/, (msg) ->
        zoi = new Zoi(robot.brain)
        word = msg.match[1]
        if zoi.exist_default(word)
            msg.reply "#{word} はデフォルトで登録されています！　変更したいときはhttps://github.com/malt03/sys2014-bot にプルリクエストしてください。"
        else if not zoi.exist(word)
            msg.reply "#{word} はまだ登録してませんよ？"
        else
            msg.reply "#{word} の登録を消しました！" if zoi.delete(word)

    robot.hear /^(.*?)\s*zoi$/i, (msg) ->
        zoi = new Zoi(robot.brain)
        word = msg.match[1]
        if url = zoi.find(word)
            msg.send url + '#' + Date.now();
        else
            msg.send zoi.random() + '#' + Date.now();
