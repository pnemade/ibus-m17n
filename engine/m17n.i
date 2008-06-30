/* vim:set et ts=4: */
/*
 * ibus-m17n - The m17n engine for IBus
 *
 * Copyright (c) 2007-2008 Huang Peng <shawn.p.huang@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

%module m17n
%{
 /* Put header files here or function declarations like below */
#include <anthy/anthy.h>
%}

%init %{
    anthy_init ();
%}

/* anthy_context_t */
%include anthy/anthy.h
struct anthy_context {};
%extend anthy_context {
    anthy_context () {
        return anthy_create_context ();
    }

    void reset () {
        anthy_reset_context (self);
    }

    int set_string (char *str) {
        return anthy_set_string (self, str);
    }

    void resize_segment (int a1, int a2) {
        anthy_resize_segment (self, a1, a2);
    }

    int get_stat (struct anthy_conv_stat *a1) {
        return anthy_get_stat (self, a1);
    }

    int get_segment_stat (int a1, struct anthy_segment_stat *a2) {
        return anthy_get_segment_stat (self, a1, a2);
    }

    char *get_segment (int a1, int a2) {
        int len;
        static char temp[512];

        len = anthy_get_segment (self, a1, a2, temp, sizeof (temp));
        if (len >= 0)
            return temp;
        else
            return NULL;
    }

    int commit_segment (int a1, int a2) {
        return anthy_commit_segment (self, a1, a2);
    }

    int set_prediction_string (const char *a1) {
        return anthy_set_prediction_string (self, a1);
    }

    int get_prediction_stat (struct anthy_prediction_stat *a1) {
        return anthy_get_prediction_stat (self, a1);
    }

    char *get_prediction (int a1) {
        int len;
        static char temp[512];

        len = anthy_get_prediction (self, a1, temp, sizeof (temp));

        if (len >= 0)
            return temp;
        else
            return NULL;
    }

    int commit_prediction (int a1) {
        return anthy_commit_prediction(self, a1);
    }

    void _print () {
        anthy_print_context (self);
    }

    int _set_encoding (int encoding) {
        return anthy_context_set_encoding (self, encoding);
    }

    int set_reconversion_mode (int mode) {
        return anthy_set_reconversion_mode (self, mode);
    }

    ~anthy_context () {
        anthy_release_context (self);
    }
};

