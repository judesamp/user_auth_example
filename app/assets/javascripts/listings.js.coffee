$ ->

  $(document).on 'click', '.invitations_button', ->
    $('.invitation_div').fadeToggle();
    $('.invitations_button').toggleClass('blue');

  $(document).on 'click', '.favors_button', -> 
    $('.favors_div').fadeToggle();
    $('.favors_button').toggleClass('blue');

  $(document).on 'click', '.ties_button', -> 
    $('.ties_div').fadeToggle();
    $('.ties_button').toggleClass('blue');

  $(document).on 'click', '.flowers_button', -> 
    $('.flowers_div').fadeToggle();
    $('.flowers_button').toggleClass('blue');

  $(document).on 'click', '.accessories_button', -> 
    $('.accessories_div').fadeToggle();
    $('.accessories_button').toggleClass('blue');

  $(document).on 'click', '.garters_button', -> 
    $('.garters_div').fadeToggle();
    $('.garters_button').toggleClass('blue');

  $(document).on 'click', '.next_invitations_images', ->
    current_offset = $(this).attr('data-image-offset');
    $.ajax
      url: '/listings/invitations'
      type: 'GET'
      data: {"offset": current_offset}

  $(document).on 'click', '.next_favors_images', -> 
    current_offset = $(this).attr('data-image-offset');
    $.ajax
      url: '/listings/favors'
      type: 'GET'
      data: {"offset": current_offset}

  $(document).on 'click', '.next_ties_images', ->
    current_offset = $(this).attr('data-image-offset'); 
    $.ajax
      url: '/listings/ties'
      type: 'GET'
      data: {"offset": current_offset}

  $(document).on 'click', '.next_flowers_images', ->
    current_offset = $(this).attr('data-image-offset');
    $.ajax
      url: '/listings/flowers'
      type: 'GET'
      data: {"offset": current_offset}

  $(document).on 'click', '.next_accessories_images', ->
    current_offset = $(this).attr('data-image-offset'); 
    $.ajax
      url: '/listings/accessories'
      type: 'GET'
      data: {"offset": current_offset}

  $(document).on 'click', '.next_garters_images', ->
    current_offset = $(this).attr('data-image-offset');
    $.ajax
      url: '/listings/garters'
      type: 'GET'
      data: {"offset": current_offset}