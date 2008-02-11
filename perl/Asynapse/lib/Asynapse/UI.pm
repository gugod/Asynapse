use strict;
use warnings;

package Asynapse::UI;
use self;

sub new {
    Template::Declare->init(roots => ['Asynapse::UI::Templates']);
    return bless {
        output => []
    }, self;
}

sub Tabs {
    push @{ self->{output} }, Template::Declare->show("tabs", args);
}

sub as_html {
    return join("\n<!-- -->\n", @{self->{output}});
}

sub as_web_page {
    return Template::Declare->show("web_page", {
        body_html => self->as_html
    });
}

{
    my $sn = 0;
    sub sn {
        $sn++;
        return "sn-$$-$sn";
    }
}

package Asynapse::UI::Templates;
use Template::Declare::Tags;
use base 'Template::Declare';
use self;

use JavaScript::Writer;
use JavaScript::Writer::jQueryHelper;

template 'web_page' => sub {
    my ($param) = args;
    html {
        head {
            with ( type => "text/javascript", src => "jquery-1.2.1.js"), script { '' };
            with ( type => "text/javascript"), script {
                outs_raw "jQuery(function(){ @{[js->as_string]} });";
            };
        };
        body {
            outs_raw($param->{body_html});
        }
    }
};

template tabs => sub {
    my @def = args;

    my $sn = Asynapse->UI->sn;

    my @body;
    with(class => "aui-tabs $sn" ), div {
        ul {
            while (@def) {
                my $name = shift @def;
                my $body = shift @def;

                my $tab_sn = Asynapse->UI->sn;
                li {
                    with(href => "#", class => "aui-link-to-tab-content $tab_sn"), a {
                        "$name"
                    };
                };
                push @body, { for => $name, sn => $tab_sn, body => $body };

                jQuery(".aui-link-to-tab-content.$tab_sn")
                    ->click(
                        sub {
                            jQuery(".aui-tab-content")->hide();
                            jQuery(".aui-tab-content.$tab_sn")->show();
                        }
                    );
            }
        }
    };

    for (@body) {
        div {
            attr { class => "aui-tab-content $_->{sn}" };
            if (!ref $_->{body}) {
                $_->{body}
            }
            else {
                "REF: $_->{body}";
            }
        }
    }

    jQuery(".aui-tab-content")->hide();
};

1;
