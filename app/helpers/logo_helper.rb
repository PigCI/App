module LogoHelper
  def render_logo
    if render_unhappy_pig_logo?
      image_tag('logo_pigci_frowning.svg', width: 54, height: 50, class: 'd-inline-block align-middle', alt: "PigCI Logo - It's a frowning pig.")
    else
      image_tag('logo_pigci.svg', width: 54, height: 50, class: 'd-inline-block align-middle', alt: "PigCI Logo - It's a pink pig.")
    end
  end

  private

  def render_unhappy_pig_logo?
    @render_unhappy_pig_logo == true
  end
end
