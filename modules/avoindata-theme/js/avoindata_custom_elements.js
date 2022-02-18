/**
 * @file
 */

'use strict';

(function ($, Drupal) {
  const openText = Drupal.t("Expand all"),
        closeText = Drupal.t("Close all");

  Drupal.behaviors.avoindataExpanderBehavior = {
    attach: function (context) {
      $('.avoindata-expander', context).once('avoindataExpanderBehavior').each(function (index) {
        // Apply the avoindataExpanderBehavior effect to the elements only once.
        $('.avoindata-expander-header', this).on('click', toggleAvoindataExpander);

        // Add 'expand all' link above the first expander if there's more than one expander.
        if (index === 0 && $('.avoindata-expander').length > 1) {
          $('<div class="clearfix"><a id="toggle-all-avoindata-expanders-link" class="pull-right" data-expanded="false">' + openText + '</a></div>').insertBefore(this);
          $('#toggle-all-avoindata-expanders-link').on('click', toggleAllAvoindataExpanders);
        }

      });
    }
  };

  function toggleAvoindataExpander() {
    if ($(this.parentElement).hasClass('open')) {
      $('.icon-wrapper i', this.parentElement).removeClass('fa-angle-up').addClass('fa-angle-down');
      $(this.parentElement).removeClass('open');
    } else {
      $('.icon-wrapper i', this.parentElement).removeClass('fa-angle-down').addClass('fa-angle-up');
      $(this.parentElement).addClass('open');
    }
    if (!$('.avoindata-expander').hasClass('open')) {
      $('#toggle-all-avoindata-expanders-link').data('expanded', true);
      toggleAllAvoindataExpanders();
    }
    if ($('.avoindata-expander').length > 0 && $('.avoindata-expander:not(.open)').length === 0) {
      $('#toggle-all-avoindata-expanders-link').data('expanded', false);
      toggleAllAvoindataExpanders();
    }
  }

  function toggleAllAvoindataExpanders() {
    if ($('#toggle-all-avoindata-expanders-link').data('expanded')) {
      $('.avoindata-expander').removeClass('open');
      $('.avoindata-expander .icon-wrapper > i').addClass('fa-angle-down').removeClass('fa-angle-up');
      $('#toggle-all-avoindata-expanders-link').data('expanded', false);
      $('#toggle-all-avoindata-expanders-link').text(openText);
    } else {
      $('.avoindata-expander').addClass('open');
      $('.avoindata-expander .icon-wrapper > i').removeClass('fa-angle-down').addClass('fa-angle-up');
      $('#toggle-all-avoindata-expanders-link').data('expanded', true);
      $('#toggle-all-avoindata-expanders-link').text(closeText);
    }

  }

  Drupal.behaviors.guideMenuListener = {
    attach: function (context) {
      $('#guide-menu-column .nav__item.open .subnav', context).each(guideMenuInit);
    }
  }

  /**
   * Initializes interaction between guide menu and content
   */
  function guideMenuInit(index, subnavElement) {
    // Make nav-item activation working also by scroll position
    guideMenuListenScroll(subnavElement);
  }

  function guideMenuListenScroll(subnavElement) {
    const $sections = $('.avoindata-section');
    // Init trigger position on top of window
    const triggerPosition = 0;
    // Only add scroll listener when there is sections in page
    if ($sections.length > 0) {
      $('body').on('scroll', function () {
        for (let i = 0; i < $sections.length; i++) {
          const section = $sections[i];
          const offsetTop = $(section).offset().top - parseInt($(section).css('marginTop'));
          const offsetTopSectionBottom = offsetTop + $(section).outerHeight();

          // As long as section is visible in screen, set it active in menu
          if (offsetTop < triggerPosition  && triggerPosition <= offsetTopSectionBottom) {
            let hash = '#' + $(section).attr('id');
            guideMenuSetActiveSubnavItemByHash(subnavElement, hash);
            break;
          }
        }
      });
    }
  }

  /**
   * Sets active item in menu by given hash
   */
  function guideMenuSetActiveSubnavItemByHash(subnavElement, hash) {
    $('.nav__item__link.active--subnav-link', subnavElement).removeClass('active--subnav-link');
    $('a[href="' + hash + '"]', subnavElement).addClass('active--subnav-link');
    var url = new URL(window.location);
    url.hash = hash;

    if (window.location.hash !== hash) {
      history.replaceState({}, "", url);
    }
  }
})(jQuery, Drupal);
