LanguageKmdView = require './language-kmd-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageKmd =
  languageKmdView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageKmdView = new LanguageKmdView(state.languageKmdViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageKmdView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-kmd:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageKmdView.destroy()

  serialize: ->
    languageKmdViewState: @languageKmdView.serialize()

  toggle: ->
    console.log 'LanguageKmd was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
