open! Core
open! Async
open! Import

module Input = struct
  type t = int list [@@deriving sexp_of]

  let parse input : t = input |> String.split_lines |> List.map ~f:Int.of_string

  let t : t Lazy_deferred.t =
    Lazy_deferred.create (fun () -> Reader.file_contents "input.txt" >>| parse)
  ;;
end

let can_sum list x =
  let list = Fqueue.to_list list in
  List.existsi list ~f:(fun i a ->
    List.sub list ~pos:(i + 1) ~len:(List.length list - (i + 1))
    |> List.exists ~f:(fun b -> a <> b && a + b = x))
;;

let rec find_first_not_possible preamble list =
  match list with
  | [] -> None
  | hd :: tl ->
    if can_sum preamble hd
    then
      find_first_not_possible (Fqueue.enqueue (snd (Fqueue.dequeue_exn preamble)) hd) tl
    else Some hd
;;

let a () =
  let%bind input = Lazy_deferred.force_exn Input.t in
  let x =
    find_first_not_possible
      (Fqueue.of_list (List.sub input ~pos:0 ~len:25))
      (List.drop input 25)
  in
  print_s [%sexp (x : int option)];
  return ()
;;

let%expect_test "a" =
  let%bind () = a () in
  let%bind () = [%expect {| (41682220) |}] in
  return ()
;;

let b () =
  let%bind input = Lazy_deferred.force_exn Input.t in
  print_s [%sexp (input : Input.t)];
  return ()
;;

let%expect_test "b" =
  let%bind () = b () in
  let%bind () =
    [%expect
      {|
    (23
     3
     36
     14
     50
     8
     2
     44
     30
     37
     20
     5
     34
     41
     31
     39
     28
     24
     49
     42
     22
     4
     45
     46
     32
     6
     35
     7
     26
     15
     21
     8
     9
     12
     25
     10
     11
     13
     14
     16
     17
     57
     18
     64
     19
     20
     22
     33
     27
     23
     24
     28
     29
     30
     38
     31
     37
     35
     21
     26
     44
     25
     32
     34
     36
     69
     40
     51
     39
     43
     41
     45
     46
     63
     49
     54
     47
     66
     64
     55
     52
     65
     53
     57
     59
     83
     61
     92
     70
     97
     79
     80
     82
     84
     86
     87
     91
     93
     96
     101
     99
     148
     105
     107
     109
     110
     112
     114
     116
     166
     204
     191
     196
     149
     159
     161
     198
     240
     170
     173
     178
     190
     219
     314
     200
     206
     222
     217
     216
     223
     224
     428
     412
     265
     319
     404
     349
     357
     308
     446
     331
     670
     343
     348
     384
     368
     407
     514
     406
     737
     628
     433
     439
     440
     584
     667
     596
     741
     749
     639
     918
     651
     656
     674
     727
     679
     691
     1040
     781
     1342
     775
     813
     839
     1023
     1406
     873
     1455
     1131
     1114
     1420
     1235
     1247
     1440
     1347
     1290
     1307
     2366
     1330
     1353
     1370
     1454
     1466
     2071
     1556
     2467
     1588
     1652
     2701
     1896
     2723
     2895
     2245
     2444
     3814
     2577
     2617
     2537
     2637
     2597
     2620
     2807
     2700
     5140
     3208
     4289
     5214
     3054
     5168
     3144
     6198
     5498
     4353
     4141
     4513
     4689
     4782
     4822
     9511
     5174
     9604
     5134
     5681
     6761
     7096
     5320
     7561
     5844
     7833
     6262
     7343
     14386
     7195
     7285
     8318
     10951
     8866
     8494
     8654
     10978
     11878
     15627
     11895
     14538
     15513
     10454
     12876
     13129
     12106
     14480
     11164
     13039
     13547
     15837
     15689
     27356
     15779
     15603
     24992
     19269
     21742
     17148
     19472
     36417
     31628
     21618
     28503
     22349
     24293
     24203
     22560
     42959
     23270
     32927
     24711
     38539
     60710
     35161
     31292
     31382
     32751
     34872
     35075
     41351
     45619
     36620
     43765
     41090
     54188
     47473
     43967
     44909
     99097
     67162
     85318
     57432
     47981
     54562
     56003
     67912
     62674
     85999
     79363
     64043
     92890
     67623
     100663
     71695
     80385
     77710
     98155
     91440
     127698
     92382
     88876
     131955
     99471
     167825
     102543
     110565
     120046
     103984
     117236
     118677
     126717
     151550
     194946
     167094
     131666
     148008
     139318
     149405
     202947
     158095
     169150
     226188
     257995
     202014
     188347
     199441
     263621
     321663
     206527
     229242
     227801
     224030
     221220
     270984
     245394
     274725
     279674
     281071
     287326
     288723
     297413
     379315
     307500
     357536
     327245
     390370
     387788
     423471
     390361
     572138
     405968
     427747
     619076
     495014
     445250
     449021
     502291
     466614
     516378
     520119
     562051
     560745
     568397
     576049
     586136
     604913
     634745
     776266
     717615
     717606
     778149
     793756
     856975
     851218
     876768
     833715
     872997
     894271
     911864
     1184229
     1165658
     1338894
     982992
     1146881
     1130448
     1279657
     1383062
     1144446
     1568824
     1191049
     1352360
     1412894
     2003856
     1435221
     2038655
     1571905
     2574111
     1690690
     2113440
     3682264
     1706712
     1767268
     1806135
     2058745
     2127438
     2129873
     2277329
     2174041
     3318487
     3140729
     2692551
     2496806
     3043050
     2543409
     2603943
     3158495
     5009177
     3007126
     3125911
     4240878
     3473980
     3397402
     4336074
     3512847
     3573403
     3880753
     3826013
     3864880
     5332536
     4257311
     5790176
     4451370
     4670847
     5040215
     5100749
     5147352
     5586459
     7677973
     5550535
     5611069
     6133037
     7299993
     8437617
     6699314
     9589847
     10711818
     7223415
     7086250
     7706766
     7399416
     7690893
     8083324
     8122191
     8928158
     8708681
     9122217
     9491585
     9711062
     10140964
     10248101
     10697887
     14708676
     11161604
     14539227
     15306739
     15828957
     14406080
     13785564
     13922729
     14930181
     14309665
     17205541
     24654181
     15090309
     15482740
     16813110
     17011482
     24212526
     17636839
     19202647
     24547044
     19632549
     19959163
     20389065
     31550709
     21859491
     24947168
     25084333
     28095229
     29229468
     28191644
     31941663
     27708293
     32727148
     29239846
     40136921
     41418067
     47424403
     37596002
     35115289
     33824592
     34648321
     39591712
     36839486
     38835196
     40021614
     40348228
     41818654
     45336233
     46806659
     56948139
     60918792
     52792626
     55803522
     55899937
     57431490
     41682220
     67842437
     84927945
     78426908
     68472913
     109740765
     68939881
     72244323
     76861100
     70664078
     71487807
     82175719
     75674682
     180404843
     80369842
     82030448
     87018453
     160602627
     113926543
     136315350
     94474846
     97485742
     124372850
     97582157
     112346298
     109524657
     144147595
     139603959
     226272841
     154274771
     140427688
     141184204
     142151885
     157850401
     242633075
     238766361
     156044524
     162400290
     167388295
     169048901
     207010399
     196543110
     191960588
     241729752
     206821144
     251760513
     195067899
     303584494
     406035284
     266621069
     354360878
     280788163
     280031647
     281611892
     282579573
     308572499
     283336089
     449000187
     436797651
     318444814
     323432819
     325093425
     489400717
     375870045
     361009489
     387028487
     664593983
     398781732
     524309325
     401889043
     475856062
     605125072
     546652716
     547409232
     562400055
     564191465
     891289760
     945434448
     606768908
     659206134
     1096169625
     930201727
     641877633
     1532967276
     794300876
     648526244
     686102914
     748037976
     1123908021
     907662205
     785810219
     1445016353
     1008657951
     877745105
     949298275
     1022508778
     1094061948
     1109052771
     1109809287
     1756695927
     1265975042
     1248646541
     1255295152
     1290403877
     1578727971
     1334629158
     1480403790
     1327980547
     1396564220
     1434140890
     1772434265
     2486390176
     1957956226
     1663555324
     1894862990
     1735108494
     1827043380
     1886403056
     1900253883
     1971807053
     2116570726
     2203114719
     2218862058
     2358455828
     2503941693
     2514621583
     2539050418
     2618384424
     3465131027
     3012868861
     4347498019
     2808384337
     2724544767
     2830705110
     4747977355
     3398663818
     3490598704
     3549958380
     3706915547
     3562151874
     4030158099
     6562827241
     3786656939
     4802512163
     4510857471
     4319685445
     4421976777
     5122326117
     5449089534
     5042992111
     5053672001
     5157434842
     5342929191
     5532929104
     5555249877
     8349843544
     7810284149
     6123208585
     6321303814
     7197514251
     6889262522
     7112110254
     7256873927
     8864350389
     14419600266
     7816815038
     8106342384
     9668292313
     16166658582
     13228668501
     8741662222
     10677575994
     10096664112
     14987558974
     10200426953
     21970330723
     10500364033
     10875858295
     11656137689
     11678458462
     12444512399
     15853772476
     13012471107
     13578177741
     19419238216
     15073688965
     14368984181
     23512835140
     15923157422
     16558477260
     16848004606
     24595434698
     18409954535
     18838326334
     18942089175
     20972522407
     20297091065
     21076285248
     21376222328
     21878885415
     22156501722
     22178822495
     39366607616
     27518201364
     27381455288
     28935628529
     31988132276
     39716329281
     43129024129
     29442673146
     30292141603
     30927461441
     59863089970
     35686330940
     45494105789
     37248280869
     37352043710
     37780415509
     49869550616
     39239180240
     47678546353
     41373376313
     84926827222
     43532724050
     44035387137
     44335324217
     49560277783
     74327528740
     54899656652
     59369587564
     58378301675
     61430805422
     80612556553
     138990858228
     67540422472
     61219603044
     66613792381
     73466746449
     73038374650
     74600324579
     75028696378
     75132459219
     77019595749
     82771904290
     155810278940
     92013870570
     84906100363
     87568111187
     87868048267
     93595664920
     93895602000
     133969912143
     135819927623
     113277958327
     117747889239
     119597904719
     249097885950
     127833395425
     142569118850
     134257977694
     139652167031
     140080538830
     146505121099
     148067071028
     149629020957
     275900466453
     152152054968
     159791500039
     167678004653
     211343554159
     172474211550
     178801702363
     207173560327
     181463713187
     347254099157
     211643491239
     231025847566
     247535936021
     257400056270
     237345793958
     301781075925
     262091373119
     267485562456
     282325048722
     273910144725
     279732705861
     413990683555
     417114583413
     356802581284
     309420520996
     319830059621
     327469504692
     366965060366
     780955743921
     390445193602
     539126869883
     866596374575
     591745569718
     418809507145
     1097622222141
     442669338805
     468371641524
     484881729979
     494745850228
     499437167077
     541395707181
     529576935575
     549810611178
     553642850586
     1280587058130
     804166371224
     856660022360
     629250580617
     809634399171
     1018182252702
     647299564313
     694434565058
     1286180134776
     809254700747
     833114532407
     2383802356917
     887181148669
     861478845950
     1014458665554
     927551068784
     1391055781525
     953253371503
     979627580207
     994183017305
     1040832874258
     1070972642756
     1433416951841
     1103453461764
     1200942414899
     1691347519893
     1276550144930
     3584744771816
     1438505281364
     1456933963484
     1534480712982
     2119294667183
     1503689265805
     1642369233154
     1880804440287
     1694593378357
     1964932307714
     1990634610433
     2318606850309
     2431888655783
     1907178648991
     3389579493065
     1932880951710
     2020460454465
     2451116980789
     2111805517014
     2304395876663
     2380003606694
     2477492559829
     2639447696263
     4684399483357
     2715055426294
     3364112612475
     3345683930355
     4339067304774
     3038169978787
     5515662538616
     4736284532446
     3336962611511
     3992609957301
     3601772027348
     3840059600701
     6965884639823
     3953341406175
     3927639103456
     4018984166005
     5116940256092
     5622232481813
     4562922497803
     4416201393677
     6682646541866
     4781888436492
     8553832517403
     5192547986123
     5354503122557
     6383853909142
     5753225405081
     8164694525151
     6375132590298
     8755268698451
     6639942006135
     6938734638859
     7355946777516
     7264601714967
     10893523743279
     7441831628049
     8709527539948
     9044579359548
     7880980509631
     7946623269461
     9608749379800
     12435871946947
     8979123891480
     15139122607593
     9198089830169
     9974436422615
     11738357031699
     13109172182597
     10547051108680
     20047906821456
     12128357995379
     12393167411216
     17799848057999
     13731079367814
     15648262178807
     13578676644994
     14203336353826
     20382495216408
     17489729889431
     19172526252784
     15322812137680
     16860104401111
     20274147920847
     24301936029160
     19684980301160
     22675409104059
     22940218519896
     18177213721649
     36908011222567
     19745140938849
     23866715027078
     23656223291277
     24125727753674
     43551695328238
     25707034640373
     24521525406595
     25971844056210
     27309756012808
     35393403117656
     27782012998820
     28901488782674
     32812542027111
     37872225105839
     32182916538791
     33500025859329
     35007792438840
     35037318122760
     37862194022809
     42043928748727
     41833437012926
     37922354660498
     52303538405415
     42302941475323
     43401364230126
     43870868692523
     47522938318355
     47781951044951
     48647253160269
     86173810167846
     59492672551599
     60979636495050
     53281600069018) |}]
  in
  return ()
;;
