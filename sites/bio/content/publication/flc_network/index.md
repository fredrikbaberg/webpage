---
title: "Extending a UGV Teleoperation FLC Interface with Wireless Network Connectivity Information"
authors:
# - Caccamo, S.
# - Parasuraman, R.
# - Båberg, F.
# - Ögren, P.
date: "2015-09-28T00:00:00"
doi: "10.1109/IROS.2015.7353987"
draft: false

# Schedule page publish date (NOT publication's date).
publishDate: "2015-09-28T00:00:00"

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["1"]

# Publication name and optional abbreviated publication name.
publication: In Intelligent Robots and Systems (IROS), 2015 IEEE/RSJ International Conference on
publication_short: In IROS 2015

abstract: |
  Teleoperated Unmanned Ground Vehicles (UGVs) are expected to play an important role in future search and rescue operations. In such tasks, two factors are crucial for a successful mission completion: operator situational awareness and robust network connectivity between operator and UGV. In this paper, we address both these factors by extending a new Free Look Control (FLC) operator interface with a graphical representation of the Radio Signal Strength (RSS) gradient at the UGV location. We also provide a new way of estimating this gradient using multiple receivers with directional antennas. The proposed approach allows the operator to stay focused on the video stream providing the crucial situational awareness, while controlling the UGV to complete the mission without moving into areas with dangerously low wireless connectivity. The approach is implemented on a KUKA youBot using commercial-off-the-shelf components. We provide experimental results showing how the proposed RSS gradient estimation method performs better than a difference approximation using omnidirectional antennas and verify that it is indeed useful for predicting the RSS development along a UGV trajectory. We also evaluate the proposed combined approach in terms of accuracy, precision, sensitivity and specificity.

# Summary. An optional shortened abstract.
summary: Teleoperated Unmanned Ground Vehicles (UGVs) are expected to play an important role in future search and rescue operations.

tags:
- search and rescue
- FLC
- network

featured: true

# links:
# - name: Custom Link
#   url: http://example.org
# url_pdf: http://eprints.soton.ac.uk/352095/1/Cushen-IMV2013.pdf
# url_code: '#'
# url_dataset: '#'
# url_poster: '#'
# url_project: ''
# url_slides: ''
# url_source: '#'
# url_video: '#'

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
# image:
#   caption: 'Image credit: [**Unsplash**](https://unsplash.com/photos/pLCdAaMFLTE)'
#   focal_point: ""
#   preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects:
- tradr

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: ""
---

<!-- {{% alert note %}}
Click the *Cite* button above to demo the feature to enable visitors to import publication metadata into their reference management software.
{{% /alert %}} -->

<!-- {{% alert note %}}
Click the *Slides* button above to demo Academic's Markdown slides feature.
{{% /alert %}} -->
<!-- 
Supplementary notes can be added here, including [code and math](https://sourcethemes.com/academic/docs/writing-markdown-latex/).
 -->
