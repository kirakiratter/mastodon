# frozen_string_literal: true

module StyleHelper
  def stylesheet_for_layout
    theme_pack = "theme_#{site_theme_for_user}.css"

    if asset_exist? theme_pack
      theme_pack
    elsif asset_exist? 'custom.css'
      'custom'
    else
      'application'
    end
  end

  def site_theme_for_user
    current_user&.account&.user&.setting_site_theme || Setting.site_theme
  rescue
    Setting.site_theme
  end

  THEME_COLORS = {
    'default' => '#282c37',
    'kkt' => '#df57a4'
  }.freeze

  # For Android tab color
  def theme_color_for_user
    THEME_COLORS[site_theme_for_user] || THEME_COLORS['default']
  end

  def asset_exist?(path)
    true if Webpacker::Manifest.lookup(path)
  rescue Webpacker::FileLoader::NotFoundError
    false
  end
end
