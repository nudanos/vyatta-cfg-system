#!/usr/bin/perl
# "show version" reports the Debian base, the running kernel and FRR
# (spec addendum section 1).
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/mock", "$FindBin::Bin/../lib";
use Test::More;

require "$FindBin::Bin/../scripts/vyatta-show-version";

my $out = '';
{
    open( my $fh, '>', \$out ) or die;
    my $old = select($fh);
    print_base_versions("$FindBin::Bin/fixture/show-version");
    select($old);
}
like( $out, qr/^Base:\s+Debian GNU\/Linux \d+/m, 'Base line' );
like( $out, qr/^Kernel:\s+\S+/m,                 'Kernel line' );
like( $out, qr/^FRR:\s+\S+/m,                    'FRR line' );
like( $out, qr/^FRR:\s+10\.4\.1-0nudanos1$/m,    'FRR version from dpkg' );

done_testing();
