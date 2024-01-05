FROM ruby:2.1.2

RUN gem install SilkSlider

# Install signalp
ADD signalp-3.0.Linux.tar.Z .
RUN tar -xvf signalp-3.0.Linux.tar.Z
ENV PATH /signalp-3.0:$PATH
RUN sed -i 's|SIGNALP=/usr/opt/signalp-3.0|SIGNALP=/signalp-3.0|g' signalp-3.0/signalp
RUN ln -s /usr/bin/awk /usr/bin/gawk

# Add TMHMM
ADD tmhmm-2.0c.Linux.tar.gz .
# RUN ls && tar -xvf tmhmm-2.0c.Linux.tar.
ENV PATH /tmhmm-2.0c/bin:$PATH
RUN ln -s /usr/bin/perl /usr/local/bin/perl

ADD test_case.faa .

RUN silk_slider test_case.faa

ENTRYPOINT ["silk_slider"]
