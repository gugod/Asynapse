if ( typeof Asynapse == 'undefined' ) {
    Asynapse = {}
}

Asynapse.TextDiff = function() {
    this.init.apply(this, arguments)
}

Asynapse.TextDiff.VERSION = "0.10";

Asynapse.TextDiff.config = {
    url: "/=/action/TextDiff.json"
}

Asynapse.TextDiff.setConfig = function ( config ) {
    var k
    for(k in config) {
        Asynapse.TextDiff.config[k] = config[k]
    }
}

Asynapse.TextDiff.prototype = {
    init: function(one, two) {
        this.config = Asynapse.TextDiff.config
        var req = new Ajax.Request(this.config.url, {
            method: 'post',
            asynchronous: false,
            postBody: $H({
                'text1': one,
                'text2': two
            }).toQueryString()
        });
        eval("this.result = " + req.transport.responseText);
        this.data = this.result.content.diff
        return this;
    },
    to_html: function() {
        var classmap = { '+': 'added', '-': 'deleted', 'u': 'unified', 'c': 'changed' };
        var ret = "<table class=\"asynapse-textdiff\"><tr><th>Left</th><th>&nbsp;</th><th>Right</th></tr>";
        for(var i = 0; i < this.data.length; i++) {
            ret += "<tr class=\"%\">".replace(/%/, classmap[this.data[i][0]]);
            ret += "<td class=\"left\">" + this.data[i][1] + "&nbsp;</td>";
            ret += "<td class=\"op\">" + this.data[i][0] + "&nbsp;</td>";
            ret += "<td class=\"right\">" + this.data[i][2] + "&nbsp;</td>";
            ret += '</tr>'
        }
        ret += '</table>';
        return ret;
    }
}

/**
=head1 NAME

Asynapse.TextDiff - perform diff.

=head1 VERSION

This document describes Asynapse.TextDiff version 0.10

=head1 SYNOPSIS

    var diff = new Asynapse.TextDiff( text1, text2 )
    $("foo").innerHTML = diff.to_html();

=head1 DESCRIPTION

The C<Asynapse.TextDiff> class provide an easy interface to see the
differences between two text pieces, just like the UNIX command
C<diff>. The usage is rather simple:

    var diff = new Asynapse.TextDiff( text1, text2 );

The returned value is an array of array. The detail structure and
meaning of each elements inside the array is the same as
Algorithm::Diff::sdiff() function on CPAN.

L<http://search.cpan.org/dist/Algorithm-Diff/lib/Algorithm/Diff.pm#sdiff>

The actually diff algorithm is performed on the server side, not
in javascript. You need to define a REST action that does the diff.

=head1 CONFIGURATION AND ENVIRONMENT

Asynapse.TextDiff needs you to install a Jifty instance with REST
plugin (which is given by default now.) And also Asynapse::TextDiff
plugin.

Since JavaScript cannot do XSS, it assumed the your Jifty instance's
URL resides at C</>, and entry points of REST servces starts from
C</=/>. It should be made possible to change this assumption in the
future to match more presets in different frameworks.

=head1 BUGS AND LIMITATIONS

The asynapse project is hosted at L<http://code.google.com/p/asynapse/>.
You may contact the authors or submit issues using the web interface.

=head1 AUTHOR

Kang-min Liu  C<< <gugod@gugod.org> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Kang-min Liu C<< <gugod@gugod.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut
*/

