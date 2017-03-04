#!/usr/bin/env python

import sys
import warnings
import vobject
import os
import pytz


def get_invitation_from_path(path):
    with open(path) as f:
        try:
            # vobject uses deprecated Exceptions
            with warnings.catch_warnings():
                warnings.simplefilter("ignore")
                return vobject.readOne(f, ignoreUnreadable=True)
        except AttributeError:
            return vobject.readOne(f, ignoreUnreadable=True)


def person_string(c):
    return "%s %s" % (c.params['CN'][0], "<%s>" % c.value.split(':')[1])

def when_str_of_start_end(s, e):
    date_format = "%a, %d %b %Y at %H:%M"
    until_format = "%H:%M" if s.date() == e.date() else date_format
    tz = os.environ['TZ']
    su = s.replace(tzinfo=pytz.utc)
    eu = e.replace(tzinfo=pytz.utc)
    ls = su.astimezone(pytz.timezone(tz))
    le = eu.astimezone(pytz.timezone(tz))
    return "%s -- %s" % (ls.strftime(date_format), le.strftime(until_format))


def pretty_print_invitation(invitation):
    event = invitation.vevent.contents
    keys = event.keys()
    if 'summary' in keys:
        title = event['summary'][0].value
    else:
        title = "Unassigned"
    if 'organizer' in keys:
        org = event['organizer'][0]
    else:
        org = "Unassigned"
    invitees = event['attendee']
    start = event['dtstart'][0].value
    end = event['dtend'][0].value
    if 'location' in keys:
        location = event['location'][0].value
    else:
        location = "Unassigned"
    if 'description' in keys:
        description = event['description'][0].value
    else:
        description = "Unassigned"
    print "="*70
    print "MEETING INVITATION".center(70)
    print "="*70
    print "Event:\n\t%s" % title.encode('utf-8')
    print "Organiser:\n\t%s" % person_string(org).encode('utf-8')
    print "Invitees:"
    for i in invitees:
        print "\t%s" % person_string(i).encode('utf-8')
    print "When:\n\t%s" % when_str_of_start_end(start, end).encode('utf-8')
    print "Location:\n\t%s" % location.encode('utf-8')
    print "---\n%s---" % description.encode('utf-8')


if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1].startswith('-'):
        sys.stderr.write("Usage: %s <filename.ics>\n" % sys.argv[0])
        sys.exit(2)
    inv = get_invitation_from_path(sys.argv[1])
    pretty_print_invitation(inv)
  
