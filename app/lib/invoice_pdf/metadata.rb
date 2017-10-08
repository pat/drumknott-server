# frozen_string_literal: true

class InvoicePdf::Metadata < InvoicePdf::Base
  def call
    update_font_families

    font "Museo Sans", :size => 10
    default_leading 5
  end

  private

  delegate :font_families, :font, :default_leading, :to => :document

  def font_path(file_name)
    Rails.root.join "app", "assets", "fonts", file_name
  end

  def update_font_families
    font_families.update(
      "Museo Slab" => {:normal => font_path("museoslab_700-webfont.ttf")}
    )
    font_families.update(
      "Museo Sans" => {
        :normal => font_path("museosans_300-webfont.ttf"),
        :bold   => font_path("museosans_500-webfont.ttf")
      }
    )
  end
end
