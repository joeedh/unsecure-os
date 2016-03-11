00000000  7F45              jg 0x47
00000002  4C                dec esp
00000003  46                inc esi
00000004  0101              add [ecx],eax
00000006  0100              add [eax],eax
00000008  0000              add [eax],al
0000000A  0000              add [eax],al
0000000C  0000              add [eax],al
0000000E  0000              add [eax],al
00000010  0200              add al,[eax]
00000012  0300              add eax,[eax]
00000014  0100              add [eax],eax
00000016  0000              add [eax],al
00000018  1000              adc [eax],al
0000001A  1000              adc [eax],al
0000001C  3400              xor al,0x0
0000001E  0000              add [eax],al
00000020  54                push esp
00000021  A5                movsd
00000022  0000              add [eax],al
00000024  0000              add [eax],al
00000026  0000              add [eax],al
00000028  3400              xor al,0x0
0000002A  2000              and [eax],al
0000002C  0300              add eax,[eax]
0000002E  2800              sub [eax],al
00000030  0F000C00          str [eax+eax]
00000034  0100              add [eax],eax
00000036  0000              add [eax],al
00000038  0010              add [eax],dl
0000003A  0000              add [eax],al
0000003C  0000              add [eax],al
0000003E  1000              adc [eax],al
00000040  0000              add [eax],al
00000042  1000              adc [eax],al
00000044  0F1E00            hint_nop48 dword [eax]
00000047  000F              add [edi],cl
00000049  1E                push ds
0000004A  0000              add [eax],al
0000004C  0500000000        add eax,0x0
00000051  1000              adc [eax],al
00000053  0001              add [ecx],al
00000055  0000              add [eax],al
00000057  0000              add [eax],al
00000059  3000              xor [eax],al
0000005B  0000              add [eax],al
0000005D  2010              and [eax],dl
0000005F  0000              add [eax],al
00000061  2010              and [eax],dl
00000063  0000              add [eax],al
00000065  0000              add [eax],al
00000067  007062            add [eax+0x62],dh
0000006A  0000              add [eax],al
0000006C  06                push es
0000006D  0000              add [eax],al
0000006F  0000              add [eax],al
00000071  1000              adc [eax],al
00000073  0001              add [ecx],al
00000075  0000              add [eax],al
00000077  0000              add [eax],al
00000079  3000              xor [eax],al
0000007B  0000              add [eax],al
0000007D  90                nop
0000007E  1000              adc [eax],al
00000080  009010001462      add [eax+0x62140010],dl
00000086  0000              add [eax],al
00000088  1462              adc al,0x62
0000008A  0000              add [eax],al
0000008C  06                push es
0000008D  0000              add [eax],al
0000008F  0000              add [eax],al
00000091  1000              adc [eax],al
00000093  0000              add [eax],al
00000095  0000              add [eax],al
00000097  0000              add [eax],al
00000099  0000              add [eax],al
0000009B  0000              add [eax],al
0000009D  0000              add [eax],al
0000009F  0000              add [eax],al
000000A1  0000              add [eax],al
000000A3  0000              add [eax],al
000000A5  0000              add [eax],al
000000A7  0000              add [eax],al
000000A9  0000              add [eax],al
000000AB  0000              add [eax],al
000000AD  0000              add [eax],al
000000AF  0000              add [eax],al
000000B1  0000              add [eax],al
000000B3  0000              add [eax],al
000000B5  0000              add [eax],al
000000B7  0000              add [eax],al
000000B9  0000              add [eax],al
000000BB  0000              add [eax],al
000000BD  0000              add [eax],al
000000BF  0000              add [eax],al
000000C1  0000              add [eax],al
000000C3  0000              add [eax],al
000000C5  0000              add [eax],al
000000C7  0000              add [eax],al
000000C9  0000              add [eax],al
000000CB  0000              add [eax],al
000000CD  0000              add [eax],al
000000CF  0000              add [eax],al
000000D1  0000              add [eax],al
000000D3  0000              add [eax],al
000000D5  0000              add [eax],al
000000D7  0000              add [eax],al
000000D9  0000              add [eax],al
000000DB  0000              add [eax],al
000000DD  0000              add [eax],al
000000DF  0000              add [eax],al
000000E1  0000              add [eax],al
000000E3  0000              add [eax],al
000000E5  0000              add [eax],al
000000E7  0000              add [eax],al
000000E9  0000              add [eax],al
000000EB  0000              add [eax],al
000000ED  0000              add [eax],al
000000EF  0000              add [eax],al
000000F1  0000              add [eax],al
000000F3  0000              add [eax],al
000000F5  0000              add [eax],al
000000F7  0000              add [eax],al
000000F9  0000              add [eax],al
000000FB  0000              add [eax],al
000000FD  0000              add [eax],al
000000FF  0000              add [eax],al
00000101  0000              add [eax],al
00000103  0000              add [eax],al
00000105  0000              add [eax],al
00000107  0000              add [eax],al
00000109  0000              add [eax],al
0000010B  0000              add [eax],al
0000010D  0000              add [eax],al
0000010F  0000              add [eax],al
00000111  0000              add [eax],al
00000113  0000              add [eax],al
00000115  0000              add [eax],al
00000117  0000              add [eax],al
00000119  0000              add [eax],al
0000011B  0000              add [eax],al
0000011D  0000              add [eax],al
0000011F  0000              add [eax],al
00000121  0000              add [eax],al
00000123  0000              add [eax],al
00000125  0000              add [eax],al
00000127  0000              add [eax],al
00000129  0000              add [eax],al
0000012B  0000              add [eax],al
0000012D  0000              add [eax],al
0000012F  0000              add [eax],al
00000131  0000              add [eax],al
00000133  0000              add [eax],al
00000135  0000              add [eax],al
00000137  0000              add [eax],al
00000139  0000              add [eax],al
0000013B  0000              add [eax],al
0000013D  0000              add [eax],al
0000013F  0000              add [eax],al
00000141  0000              add [eax],al
00000143  0000              add [eax],al
00000145  0000              add [eax],al
00000147  0000              add [eax],al
00000149  0000              add [eax],al
0000014B  0000              add [eax],al
0000014D  0000              add [eax],al
0000014F  0000              add [eax],al
00000151  0000              add [eax],al
00000153  0000              add [eax],al
00000155  0000              add [eax],al
00000157  0000              add [eax],al
00000159  0000              add [eax],al
0000015B  0000              add [eax],al
0000015D  0000              add [eax],al
0000015F  0000              add [eax],al
00000161  0000              add [eax],al
00000163  0000              add [eax],al
00000165  0000              add [eax],al
00000167  0000              add [eax],al
00000169  0000              add [eax],al
0000016B  0000              add [eax],al
0000016D  0000              add [eax],al
0000016F  0000              add [eax],al
00000171  0000              add [eax],al
00000173  0000              add [eax],al
00000175  0000              add [eax],al
00000177  0000              add [eax],al
00000179  0000              add [eax],al
0000017B  0000              add [eax],al
0000017D  0000              add [eax],al
0000017F  0000              add [eax],al
00000181  0000              add [eax],al
00000183  0000              add [eax],al
00000185  0000              add [eax],al
00000187  0000              add [eax],al
00000189  0000              add [eax],al
0000018B  0000              add [eax],al
0000018D  0000              add [eax],al
0000018F  0000              add [eax],al
00000191  0000              add [eax],al
00000193  0000              add [eax],al
00000195  0000              add [eax],al
00000197  0000              add [eax],al
00000199  0000              add [eax],al
0000019B  0000              add [eax],al
0000019D  0000              add [eax],al
0000019F  0000              add [eax],al
000001A1  0000              add [eax],al
000001A3  0000              add [eax],al
000001A5  0000              add [eax],al
000001A7  0000              add [eax],al
000001A9  0000              add [eax],al
000001AB  0000              add [eax],al
000001AD  0000              add [eax],al
000001AF  0000              add [eax],al
000001B1  0000              add [eax],al
000001B3  0000              add [eax],al
000001B5  0000              add [eax],al
000001B7  0000              add [eax],al
000001B9  0000              add [eax],al
000001BB  0000              add [eax],al
000001BD  0000              add [eax],al
000001BF  0000              add [eax],al
000001C1  0000              add [eax],al
000001C3  0000              add [eax],al
000001C5  0000              add [eax],al
000001C7  0000              add [eax],al
000001C9  0000              add [eax],al
000001CB  0000              add [eax],al
000001CD  0000              add [eax],al
000001CF  0000              add [eax],al
000001D1  0000              add [eax],al
000001D3  0000              add [eax],al
000001D5  0000              add [eax],al
000001D7  0000              add [eax],al
000001D9  0000              add [eax],al
000001DB  0000              add [eax],al
000001DD  0000              add [eax],al
000001DF  0000              add [eax],al
000001E1  0000              add [eax],al
000001E3  0000              add [eax],al
000001E5  0000              add [eax],al
000001E7  0000              add [eax],al
000001E9  0000              add [eax],al
000001EB  0000              add [eax],al
000001ED  0000              add [eax],al
000001EF  0000              add [eax],al
000001F1  0000              add [eax],al
000001F3  0000              add [eax],al
000001F5  0000              add [eax],al
000001F7  0000              add [eax],al
000001F9  0000              add [eax],al
000001FB  0000              add [eax],al
000001FD  0000              add [eax],al
000001FF  0000              add [eax],al
00000201  0000              add [eax],al
00000203  0000              add [eax],al
00000205  0000              add [eax],al
00000207  0000              add [eax],al
00000209  0000              add [eax],al
0000020B  0000              add [eax],al
0000020D  0000              add [eax],al
0000020F  0000              add [eax],al
00000211  0000              add [eax],al
00000213  0000              add [eax],al
00000215  0000              add [eax],al
00000217  0000              add [eax],al
00000219  0000              add [eax],al
0000021B  0000              add [eax],al
0000021D  0000              add [eax],al
0000021F  0000              add [eax],al
00000221  0000              add [eax],al
00000223  0000              add [eax],al
00000225  0000              add [eax],al
00000227  0000              add [eax],al
00000229  0000              add [eax],al
0000022B  0000              add [eax],al
0000022D  0000              add [eax],al
0000022F  0000              add [eax],al
00000231  0000              add [eax],al
00000233  0000              add [eax],al
00000235  0000              add [eax],al
00000237  0000              add [eax],al
00000239  0000              add [eax],al
0000023B  0000              add [eax],al
0000023D  0000              add [eax],al
0000023F  0000              add [eax],al
00000241  0000              add [eax],al
00000243  0000              add [eax],al
00000245  0000              add [eax],al
00000247  0000              add [eax],al
00000249  0000              add [eax],al
0000024B  0000              add [eax],al
0000024D  0000              add [eax],al
0000024F  0000              add [eax],al
00000251  0000              add [eax],al
00000253  0000              add [eax],al
00000255  0000              add [eax],al
00000257  0000              add [eax],al
00000259  0000              add [eax],al
0000025B  0000              add [eax],al
0000025D  0000              add [eax],al
0000025F  0000              add [eax],al
00000261  0000              add [eax],al
00000263  0000              add [eax],al
00000265  0000              add [eax],al
00000267  0000              add [eax],al
00000269  0000              add [eax],al
0000026B  0000              add [eax],al
0000026D  0000              add [eax],al
0000026F  0000              add [eax],al
00000271  0000              add [eax],al
00000273  0000              add [eax],al
00000275  0000              add [eax],al
00000277  0000              add [eax],al
00000279  0000              add [eax],al
0000027B  0000              add [eax],al
0000027D  0000              add [eax],al
0000027F  0000              add [eax],al
00000281  0000              add [eax],al
00000283  0000              add [eax],al
00000285  0000              add [eax],al
00000287  0000              add [eax],al
00000289  0000              add [eax],al
0000028B  0000              add [eax],al
0000028D  0000              add [eax],al
0000028F  0000              add [eax],al
00000291  0000              add [eax],al
00000293  0000              add [eax],al
00000295  0000              add [eax],al
00000297  0000              add [eax],al
00000299  0000              add [eax],al
0000029B  0000              add [eax],al
0000029D  0000              add [eax],al
0000029F  0000              add [eax],al
000002A1  0000              add [eax],al
000002A3  0000              add [eax],al
000002A5  0000              add [eax],al
000002A7  0000              add [eax],al
000002A9  0000              add [eax],al
000002AB  0000              add [eax],al
000002AD  0000              add [eax],al
000002AF  0000              add [eax],al
000002B1  0000              add [eax],al
000002B3  0000              add [eax],al
000002B5  0000              add [eax],al
000002B7  0000              add [eax],al
000002B9  0000              add [eax],al
000002BB  0000              add [eax],al
000002BD  0000              add [eax],al
000002BF  0000              add [eax],al
000002C1  0000              add [eax],al
000002C3  0000              add [eax],al
000002C5  0000              add [eax],al
000002C7  0000              add [eax],al
000002C9  0000              add [eax],al
000002CB  0000              add [eax],al
000002CD  0000              add [eax],al
000002CF  0000              add [eax],al
000002D1  0000              add [eax],al
000002D3  0000              add [eax],al
000002D5  0000              add [eax],al
000002D7  0000              add [eax],al
000002D9  0000              add [eax],al
000002DB  0000              add [eax],al
000002DD  0000              add [eax],al
000002DF  0000              add [eax],al
000002E1  0000              add [eax],al
000002E3  0000              add [eax],al
000002E5  0000              add [eax],al
000002E7  0000              add [eax],al
000002E9  0000              add [eax],al
000002EB  0000              add [eax],al
000002ED  0000              add [eax],al
000002EF  0000              add [eax],al
000002F1  0000              add [eax],al
000002F3  0000              add [eax],al
000002F5  0000              add [eax],al
000002F7  0000              add [eax],al
000002F9  0000              add [eax],al
000002FB  0000              add [eax],al
000002FD  0000              add [eax],al
000002FF  0000              add [eax],al
00000301  0000              add [eax],al
00000303  0000              add [eax],al
00000305  0000              add [eax],al
00000307  0000              add [eax],al
00000309  0000              add [eax],al
0000030B  0000              add [eax],al
0000030D  0000              add [eax],al
0000030F  0000              add [eax],al
00000311  0000              add [eax],al
00000313  0000              add [eax],al
00000315  0000              add [eax],al
00000317  0000              add [eax],al
00000319  0000              add [eax],al
0000031B  0000              add [eax],al
0000031D  0000              add [eax],al
0000031F  0000              add [eax],al
00000321  0000              add [eax],al
00000323  0000              add [eax],al
00000325  0000              add [eax],al
00000327  0000              add [eax],al
00000329  0000              add [eax],al
0000032B  0000              add [eax],al
0000032D  0000              add [eax],al
0000032F  0000              add [eax],al
00000331  0000              add [eax],al
00000333  0000              add [eax],al
00000335  0000              add [eax],al
00000337  0000              add [eax],al
00000339  0000              add [eax],al
0000033B  0000              add [eax],al
0000033D  0000              add [eax],al
0000033F  0000              add [eax],al
00000341  0000              add [eax],al
00000343  0000              add [eax],al
00000345  0000              add [eax],al
00000347  0000              add [eax],al
00000349  0000              add [eax],al
0000034B  0000              add [eax],al
0000034D  0000              add [eax],al
0000034F  0000              add [eax],al
00000351  0000              add [eax],al
00000353  0000              add [eax],al
00000355  0000              add [eax],al
00000357  0000              add [eax],al
00000359  0000              add [eax],al
0000035B  0000              add [eax],al
0000035D  0000              add [eax],al
0000035F  0000              add [eax],al
00000361  0000              add [eax],al
00000363  0000              add [eax],al
00000365  0000              add [eax],al
00000367  0000              add [eax],al
00000369  0000              add [eax],al
0000036B  0000              add [eax],al
0000036D  0000              add [eax],al
0000036F  0000              add [eax],al
00000371  0000              add [eax],al
00000373  0000              add [eax],al
00000375  0000              add [eax],al
00000377  0000              add [eax],al
00000379  0000              add [eax],al
0000037B  0000              add [eax],al
0000037D  0000              add [eax],al
0000037F  0000              add [eax],al
00000381  0000              add [eax],al
00000383  0000              add [eax],al
00000385  0000              add [eax],al
00000387  0000              add [eax],al
00000389  0000              add [eax],al
0000038B  0000              add [eax],al
0000038D  0000              add [eax],al
0000038F  0000              add [eax],al
00000391  0000              add [eax],al
00000393  0000              add [eax],al
00000395  0000              add [eax],al
00000397  0000              add [eax],al
00000399  0000              add [eax],al
0000039B  0000              add [eax],al
0000039D  0000              add [eax],al
0000039F  0000              add [eax],al
000003A1  0000              add [eax],al
000003A3  0000              add [eax],al
000003A5  0000              add [eax],al
000003A7  0000              add [eax],al
000003A9  0000              add [eax],al
000003AB  0000              add [eax],al
000003AD  0000              add [eax],al
000003AF  0000              add [eax],al
000003B1  0000              add [eax],al
000003B3  0000              add [eax],al
000003B5  0000              add [eax],al
000003B7  0000              add [eax],al
000003B9  0000              add [eax],al
000003BB  0000              add [eax],al
000003BD  0000              add [eax],al
000003BF  0000              add [eax],al
000003C1  0000              add [eax],al
000003C3  0000              add [eax],al
000003C5  0000              add [eax],al
000003C7  0000              add [eax],al
000003C9  0000              add [eax],al
000003CB  0000              add [eax],al
000003CD  0000              add [eax],al
000003CF  0000              add [eax],al
000003D1  0000              add [eax],al
000003D3  0000              add [eax],al
000003D5  0000              add [eax],al
000003D7  0000              add [eax],al
000003D9  0000              add [eax],al
000003DB  0000              add [eax],al
000003DD  0000              add [eax],al
000003DF  0000              add [eax],al
000003E1  0000              add [eax],al
000003E3  0000              add [eax],al
000003E5  0000              add [eax],al
000003E7  0000              add [eax],al
000003E9  0000              add [eax],al
000003EB  0000              add [eax],al
000003ED  0000              add [eax],al
000003EF  0000              add [eax],al
000003F1  0000              add [eax],al
000003F3  0000              add [eax],al
000003F5  0000              add [eax],al
000003F7  0000              add [eax],al
000003F9  0000              add [eax],al
000003FB  0000              add [eax],al
000003FD  0000              add [eax],al
000003FF  0000              add [eax],al
00000401  0000              add [eax],al
00000403  0000              add [eax],al
00000405  0000              add [eax],al
00000407  0000              add [eax],al
00000409  0000              add [eax],al
0000040B  0000              add [eax],al
0000040D  0000              add [eax],al
0000040F  0000              add [eax],al
00000411  0000              add [eax],al
00000413  0000              add [eax],al
00000415  0000              add [eax],al
00000417  0000              add [eax],al
00000419  0000              add [eax],al
0000041B  0000              add [eax],al
0000041D  0000              add [eax],al
0000041F  0000              add [eax],al
00000421  0000              add [eax],al
00000423  0000              add [eax],al
00000425  0000              add [eax],al
00000427  0000              add [eax],al
00000429  0000              add [eax],al
0000042B  0000              add [eax],al
0000042D  0000              add [eax],al
0000042F  0000              add [eax],al
00000431  0000              add [eax],al
00000433  0000              add [eax],al
00000435  0000              add [eax],al
00000437  0000              add [eax],al
00000439  0000              add [eax],al
0000043B  0000              add [eax],al
0000043D  0000              add [eax],al
0000043F  0000              add [eax],al
00000441  0000              add [eax],al
00000443  0000              add [eax],al
00000445  0000              add [eax],al
00000447  0000              add [eax],al
00000449  0000              add [eax],al
0000044B  0000              add [eax],al
0000044D  0000              add [eax],al
0000044F  0000              add [eax],al
00000451  0000              add [eax],al
00000453  0000              add [eax],al
00000455  0000              add [eax],al
00000457  0000              add [eax],al
00000459  0000              add [eax],al
0000045B  0000              add [eax],al
0000045D  0000              add [eax],al
0000045F  0000              add [eax],al
00000461  0000              add [eax],al
00000463  0000              add [eax],al
00000465  0000              add [eax],al
00000467  0000              add [eax],al
00000469  0000              add [eax],al
0000046B  0000              add [eax],al
0000046D  0000              add [eax],al
0000046F  0000              add [eax],al
00000471  0000              add [eax],al
00000473  0000              add [eax],al
00000475  0000              add [eax],al
00000477  0000              add [eax],al
00000479  0000              add [eax],al
0000047B  0000              add [eax],al
0000047D  0000              add [eax],al
0000047F  0000              add [eax],al
00000481  0000              add [eax],al
00000483  0000              add [eax],al
00000485  0000              add [eax],al
00000487  0000              add [eax],al
00000489  0000              add [eax],al
0000048B  0000              add [eax],al
0000048D  0000              add [eax],al
0000048F  0000              add [eax],al
00000491  0000              add [eax],al
00000493  0000              add [eax],al
00000495  0000              add [eax],al
00000497  0000              add [eax],al
00000499  0000              add [eax],al
0000049B  0000              add [eax],al
0000049D  0000              add [eax],al
0000049F  0000              add [eax],al
000004A1  0000              add [eax],al
000004A3  0000              add [eax],al
000004A5  0000              add [eax],al
000004A7  0000              add [eax],al
000004A9  0000              add [eax],al
000004AB  0000              add [eax],al
000004AD  0000              add [eax],al
000004AF  0000              add [eax],al
000004B1  0000              add [eax],al
000004B3  0000              add [eax],al
000004B5  0000              add [eax],al
000004B7  0000              add [eax],al
000004B9  0000              add [eax],al
000004BB  0000              add [eax],al
000004BD  0000              add [eax],al
000004BF  0000              add [eax],al
000004C1  0000              add [eax],al
000004C3  0000              add [eax],al
000004C5  0000              add [eax],al
000004C7  0000              add [eax],al
000004C9  0000              add [eax],al
000004CB  0000              add [eax],al
000004CD  0000              add [eax],al
000004CF  0000              add [eax],al
000004D1  0000              add [eax],al
000004D3  0000              add [eax],al
000004D5  0000              add [eax],al
000004D7  0000              add [eax],al
000004D9  0000              add [eax],al
000004DB  0000              add [eax],al
000004DD  0000              add [eax],al
000004DF  0000              add [eax],al
000004E1  0000              add [eax],al
000004E3  0000              add [eax],al
000004E5  0000              add [eax],al
000004E7  0000              add [eax],al
000004E9  0000              add [eax],al
000004EB  0000              add [eax],al
000004ED  0000              add [eax],al
000004EF  0000              add [eax],al
000004F1  0000              add [eax],al
000004F3  0000              add [eax],al
000004F5  0000              add [eax],al
000004F7  0000              add [eax],al
000004F9  0000              add [eax],al
000004FB  0000              add [eax],al
000004FD  0000              add [eax],al
000004FF  0000              add [eax],al
00000501  0000              add [eax],al
00000503  0000              add [eax],al
00000505  0000              add [eax],al
00000507  0000              add [eax],al
00000509  0000              add [eax],al
0000050B  0000              add [eax],al
0000050D  0000              add [eax],al
0000050F  0000              add [eax],al
00000511  0000              add [eax],al
00000513  0000              add [eax],al
00000515  0000              add [eax],al
00000517  0000              add [eax],al
00000519  0000              add [eax],al
0000051B  0000              add [eax],al
0000051D  0000              add [eax],al
0000051F  0000              add [eax],al
00000521  0000              add [eax],al
00000523  0000              add [eax],al
00000525  0000              add [eax],al
00000527  0000              add [eax],al
00000529  0000              add [eax],al
0000052B  0000              add [eax],al
0000052D  0000              add [eax],al
0000052F  0000              add [eax],al
00000531  0000              add [eax],al
00000533  0000              add [eax],al
00000535  0000              add [eax],al
00000537  0000              add [eax],al
00000539  0000              add [eax],al
0000053B  0000              add [eax],al
0000053D  0000              add [eax],al
0000053F  0000              add [eax],al
00000541  0000              add [eax],al
00000543  0000              add [eax],al
00000545  0000              add [eax],al
00000547  0000              add [eax],al
00000549  0000              add [eax],al
0000054B  0000              add [eax],al
0000054D  0000              add [eax],al
0000054F  0000              add [eax],al
00000551  0000              add [eax],al
00000553  0000              add [eax],al
00000555  0000              add [eax],al
00000557  0000              add [eax],al
00000559  0000              add [eax],al
0000055B  0000              add [eax],al
0000055D  0000              add [eax],al
0000055F  0000              add [eax],al
00000561  0000              add [eax],al
00000563  0000              add [eax],al
00000565  0000              add [eax],al
00000567  0000              add [eax],al
00000569  0000              add [eax],al
0000056B  0000              add [eax],al
0000056D  0000              add [eax],al
0000056F  0000              add [eax],al
00000571  0000              add [eax],al
00000573  0000              add [eax],al
00000575  0000              add [eax],al
00000577  0000              add [eax],al
00000579  0000              add [eax],al
0000057B  0000              add [eax],al
0000057D  0000              add [eax],al
0000057F  0000              add [eax],al
00000581  0000              add [eax],al
00000583  0000              add [eax],al
00000585  0000              add [eax],al
00000587  0000              add [eax],al
00000589  0000              add [eax],al
0000058B  0000              add [eax],al
0000058D  0000              add [eax],al
0000058F  0000              add [eax],al
00000591  0000              add [eax],al
00000593  0000              add [eax],al
00000595  0000              add [eax],al
00000597  0000              add [eax],al
00000599  0000              add [eax],al
0000059B  0000              add [eax],al
0000059D  0000              add [eax],al
0000059F  0000              add [eax],al
000005A1  0000              add [eax],al
000005A3  0000              add [eax],al
000005A5  0000              add [eax],al
000005A7  0000              add [eax],al
000005A9  0000              add [eax],al
000005AB  0000              add [eax],al
000005AD  0000              add [eax],al
000005AF  0000              add [eax],al
000005B1  0000              add [eax],al
000005B3  0000              add [eax],al
000005B5  0000              add [eax],al
000005B7  0000              add [eax],al
000005B9  0000              add [eax],al
000005BB  0000              add [eax],al
000005BD  0000              add [eax],al
000005BF  0000              add [eax],al
000005C1  0000              add [eax],al
000005C3  0000              add [eax],al
000005C5  0000              add [eax],al
000005C7  0000              add [eax],al
000005C9  0000              add [eax],al
000005CB  0000              add [eax],al
000005CD  0000              add [eax],al
000005CF  0000              add [eax],al
000005D1  0000              add [eax],al
000005D3  0000              add [eax],al
000005D5  0000              add [eax],al
000005D7  0000              add [eax],al
000005D9  0000              add [eax],al
000005DB  0000              add [eax],al
000005DD  0000              add [eax],al
000005DF  0000              add [eax],al
000005E1  0000              add [eax],al
000005E3  0000              add [eax],al
000005E5  0000              add [eax],al
000005E7  0000              add [eax],al
000005E9  0000              add [eax],al
000005EB  0000              add [eax],al
000005ED  0000              add [eax],al
000005EF  0000              add [eax],al
000005F1  0000              add [eax],al
000005F3  0000              add [eax],al
000005F5  0000              add [eax],al
000005F7  0000              add [eax],al
000005F9  0000              add [eax],al
000005FB  0000              add [eax],al
000005FD  0000              add [eax],al
000005FF  0000              add [eax],al
00000601  0000              add [eax],al
00000603  0000              add [eax],al
00000605  0000              add [eax],al
00000607  0000              add [eax],al
00000609  0000              add [eax],al
0000060B  0000              add [eax],al
0000060D  0000              add [eax],al
0000060F  0000              add [eax],al
00000611  0000              add [eax],al
00000613  0000              add [eax],al
00000615  0000              add [eax],al
00000617  0000              add [eax],al
00000619  0000              add [eax],al
0000061B  0000              add [eax],al
0000061D  0000              add [eax],al
0000061F  0000              add [eax],al
00000621  0000              add [eax],al
00000623  0000              add [eax],al
00000625  0000              add [eax],al
00000627  0000              add [eax],al
00000629  0000              add [eax],al
0000062B  0000              add [eax],al
0000062D  0000              add [eax],al
0000062F  0000              add [eax],al
00000631  0000              add [eax],al
00000633  0000              add [eax],al
00000635  0000              add [eax],al
00000637  0000              add [eax],al
00000639  0000              add [eax],al
0000063B  0000              add [eax],al
0000063D  0000              add [eax],al
0000063F  0000              add [eax],al
00000641  0000              add [eax],al
00000643  0000              add [eax],al
00000645  0000              add [eax],al
00000647  0000              add [eax],al
00000649  0000              add [eax],al
0000064B  0000              add [eax],al
0000064D  0000              add [eax],al
0000064F  0000              add [eax],al
00000651  0000              add [eax],al
00000653  0000              add [eax],al
00000655  0000              add [eax],al
00000657  0000              add [eax],al
00000659  0000              add [eax],al
0000065B  0000              add [eax],al
0000065D  0000              add [eax],al
0000065F  0000              add [eax],al
00000661  0000              add [eax],al
00000663  0000              add [eax],al
00000665  0000              add [eax],al
00000667  0000              add [eax],al
00000669  0000              add [eax],al
0000066B  0000              add [eax],al
0000066D  0000              add [eax],al
0000066F  0000              add [eax],al
00000671  0000              add [eax],al
00000673  0000              add [eax],al
00000675  0000              add [eax],al
00000677  0000              add [eax],al
00000679  0000              add [eax],al
0000067B  0000              add [eax],al
0000067D  0000              add [eax],al
0000067F  0000              add [eax],al
00000681  0000              add [eax],al
00000683  0000              add [eax],al
00000685  0000              add [eax],al
00000687  0000              add [eax],al
00000689  0000              add [eax],al
0000068B  0000              add [eax],al
0000068D  0000              add [eax],al
0000068F  0000              add [eax],al
00000691  0000              add [eax],al
00000693  0000              add [eax],al
00000695  0000              add [eax],al
00000697  0000              add [eax],al
00000699  0000              add [eax],al
0000069B  0000              add [eax],al
0000069D  0000              add [eax],al
0000069F  0000              add [eax],al
000006A1  0000              add [eax],al
000006A3  0000              add [eax],al
000006A5  0000              add [eax],al
000006A7  0000              add [eax],al
000006A9  0000              add [eax],al
000006AB  0000              add [eax],al
000006AD  0000              add [eax],al
000006AF  0000              add [eax],al
000006B1  0000              add [eax],al
000006B3  0000              add [eax],al
000006B5  0000              add [eax],al
000006B7  0000              add [eax],al
000006B9  0000              add [eax],al
000006BB  0000              add [eax],al
000006BD  0000              add [eax],al
000006BF  0000              add [eax],al
000006C1  0000              add [eax],al
000006C3  0000              add [eax],al
000006C5  0000              add [eax],al
000006C7  0000              add [eax],al
000006C9  0000              add [eax],al
000006CB  0000              add [eax],al
000006CD  0000              add [eax],al
000006CF  0000              add [eax],al
000006D1  0000              add [eax],al
000006D3  0000              add [eax],al
000006D5  0000              add [eax],al
000006D7  0000              add [eax],al
000006D9  0000              add [eax],al
000006DB  0000              add [eax],al
000006DD  0000              add [eax],al
000006DF  0000              add [eax],al
000006E1  0000              add [eax],al
000006E3  0000              add [eax],al
000006E5  0000              add [eax],al
000006E7  0000              add [eax],al
000006E9  0000              add [eax],al
000006EB  0000              add [eax],al
000006ED  0000              add [eax],al
000006EF  0000              add [eax],al
000006F1  0000              add [eax],al
000006F3  0000              add [eax],al
000006F5  0000              add [eax],al
000006F7  0000              add [eax],al
000006F9  0000              add [eax],al
000006FB  0000              add [eax],al
000006FD  0000              add [eax],al
000006FF  0000              add [eax],al
00000701  0000              add [eax],al
00000703  0000              add [eax],al
00000705  0000              add [eax],al
00000707  0000              add [eax],al
00000709  0000              add [eax],al
0000070B  0000              add [eax],al
0000070D  0000              add [eax],al
0000070F  0000              add [eax],al
00000711  0000              add [eax],al
00000713  0000              add [eax],al
00000715  0000              add [eax],al
00000717  0000              add [eax],al
00000719  0000              add [eax],al
0000071B  0000              add [eax],al
0000071D  0000              add [eax],al
0000071F  0000              add [eax],al
00000721  0000              add [eax],al
00000723  0000              add [eax],al
00000725  0000              add [eax],al
00000727  0000              add [eax],al
00000729  0000              add [eax],al
0000072B  0000              add [eax],al
0000072D  0000              add [eax],al
0000072F  0000              add [eax],al
00000731  0000              add [eax],al
00000733  0000              add [eax],al
00000735  0000              add [eax],al
00000737  0000              add [eax],al
00000739  0000              add [eax],al
0000073B  0000              add [eax],al
0000073D  0000              add [eax],al
0000073F  0000              add [eax],al
00000741  0000              add [eax],al
00000743  0000              add [eax],al
00000745  0000              add [eax],al
00000747  0000              add [eax],al
00000749  0000              add [eax],al
0000074B  0000              add [eax],al
0000074D  0000              add [eax],al
0000074F  0000              add [eax],al
00000751  0000              add [eax],al
00000753  0000              add [eax],al
00000755  0000              add [eax],al
00000757  0000              add [eax],al
00000759  0000              add [eax],al
0000075B  0000              add [eax],al
0000075D  0000              add [eax],al
0000075F  0000              add [eax],al
00000761  0000              add [eax],al
00000763  0000              add [eax],al
00000765  0000              add [eax],al
00000767  0000              add [eax],al
00000769  0000              add [eax],al
0000076B  0000              add [eax],al
0000076D  0000              add [eax],al
0000076F  0000              add [eax],al
00000771  0000              add [eax],al
00000773  0000              add [eax],al
00000775  0000              add [eax],al
00000777  0000              add [eax],al
00000779  0000              add [eax],al
0000077B  0000              add [eax],al
0000077D  0000              add [eax],al
0000077F  0000              add [eax],al
00000781  0000              add [eax],al
00000783  0000              add [eax],al
00000785  0000              add [eax],al
00000787  0000              add [eax],al
00000789  0000              add [eax],al
0000078B  0000              add [eax],al
0000078D  0000              add [eax],al
0000078F  0000              add [eax],al
00000791  0000              add [eax],al
00000793  0000              add [eax],al
00000795  0000              add [eax],al
00000797  0000              add [eax],al
00000799  0000              add [eax],al
0000079B  0000              add [eax],al
0000079D  0000              add [eax],al
0000079F  0000              add [eax],al
000007A1  0000              add [eax],al
000007A3  0000              add [eax],al
000007A5  0000              add [eax],al
000007A7  0000              add [eax],al
000007A9  0000              add [eax],al
000007AB  0000              add [eax],al
000007AD  0000              add [eax],al
000007AF  0000              add [eax],al
000007B1  0000              add [eax],al
000007B3  0000              add [eax],al
000007B5  0000              add [eax],al
000007B7  0000              add [eax],al
000007B9  0000              add [eax],al
000007BB  0000              add [eax],al
000007BD  0000              add [eax],al
000007BF  0000              add [eax],al
000007C1  0000              add [eax],al
000007C3  0000              add [eax],al
000007C5  0000              add [eax],al
000007C7  0000              add [eax],al
000007C9  0000              add [eax],al
000007CB  0000              add [eax],al
000007CD  0000              add [eax],al
000007CF  0000              add [eax],al
000007D1  0000              add [eax],al
000007D3  0000              add [eax],al
000007D5  0000              add [eax],al
000007D7  0000              add [eax],al
000007D9  0000              add [eax],al
000007DB  0000              add [eax],al
000007DD  0000              add [eax],al
000007DF  0000              add [eax],al
000007E1  0000              add [eax],al
000007E3  0000              add [eax],al
000007E5  0000              add [eax],al
000007E7  0000              add [eax],al
000007E9  0000              add [eax],al
000007EB  0000              add [eax],al
000007ED  0000              add [eax],al
000007EF  0000              add [eax],al
000007F1  0000              add [eax],al
000007F3  0000              add [eax],al
000007F5  0000              add [eax],al
000007F7  0000              add [eax],al
000007F9  0000              add [eax],al
000007FB  0000              add [eax],al
000007FD  0000              add [eax],al
000007FF  0000              add [eax],al
00000801  0000              add [eax],al
00000803  0000              add [eax],al
00000805  0000              add [eax],al
00000807  0000              add [eax],al
00000809  0000              add [eax],al
0000080B  0000              add [eax],al
0000080D  0000              add [eax],al
0000080F  0000              add [eax],al
00000811  0000              add [eax],al
00000813  0000              add [eax],al
00000815  0000              add [eax],al
00000817  0000              add [eax],al
00000819  0000              add [eax],al
0000081B  0000              add [eax],al
0000081D  0000              add [eax],al
0000081F  0000              add [eax],al
00000821  0000              add [eax],al
00000823  0000              add [eax],al
00000825  0000              add [eax],al
00000827  0000              add [eax],al
00000829  0000              add [eax],al
0000082B  0000              add [eax],al
0000082D  0000              add [eax],al
0000082F  0000              add [eax],al
00000831  0000              add [eax],al
00000833  0000              add [eax],al
00000835  0000              add [eax],al
00000837  0000              add [eax],al
00000839  0000              add [eax],al
0000083B  0000              add [eax],al
0000083D  0000              add [eax],al
0000083F  0000              add [eax],al
00000841  0000              add [eax],al
00000843  0000              add [eax],al
00000845  0000              add [eax],al
00000847  0000              add [eax],al
00000849  0000              add [eax],al
0000084B  0000              add [eax],al
0000084D  0000              add [eax],al
0000084F  0000              add [eax],al
00000851  0000              add [eax],al
00000853  0000              add [eax],al
00000855  0000              add [eax],al
00000857  0000              add [eax],al
00000859  0000              add [eax],al
0000085B  0000              add [eax],al
0000085D  0000              add [eax],al
0000085F  0000              add [eax],al
00000861  0000              add [eax],al
00000863  0000              add [eax],al
00000865  0000              add [eax],al
00000867  0000              add [eax],al
00000869  0000              add [eax],al
0000086B  0000              add [eax],al
0000086D  0000              add [eax],al
0000086F  0000              add [eax],al
00000871  0000              add [eax],al
00000873  0000              add [eax],al
00000875  0000              add [eax],al
00000877  0000              add [eax],al
00000879  0000              add [eax],al
0000087B  0000              add [eax],al
0000087D  0000              add [eax],al
0000087F  0000              add [eax],al
00000881  0000              add [eax],al
00000883  0000              add [eax],al
00000885  0000              add [eax],al
00000887  0000              add [eax],al
00000889  0000              add [eax],al
0000088B  0000              add [eax],al
0000088D  0000              add [eax],al
0000088F  0000              add [eax],al
00000891  0000              add [eax],al
00000893  0000              add [eax],al
00000895  0000              add [eax],al
00000897  0000              add [eax],al
00000899  0000              add [eax],al
0000089B  0000              add [eax],al
0000089D  0000              add [eax],al
0000089F  0000              add [eax],al
000008A1  0000              add [eax],al
000008A3  0000              add [eax],al
000008A5  0000              add [eax],al
000008A7  0000              add [eax],al
000008A9  0000              add [eax],al
000008AB  0000              add [eax],al
000008AD  0000              add [eax],al
000008AF  0000              add [eax],al
000008B1  0000              add [eax],al
000008B3  0000              add [eax],al
000008B5  0000              add [eax],al
000008B7  0000              add [eax],al
000008B9  0000              add [eax],al
000008BB  0000              add [eax],al
000008BD  0000              add [eax],al
000008BF  0000              add [eax],al
000008C1  0000              add [eax],al
000008C3  0000              add [eax],al
000008C5  0000              add [eax],al
000008C7  0000              add [eax],al
000008C9  0000              add [eax],al
000008CB  0000              add [eax],al
000008CD  0000              add [eax],al
000008CF  0000              add [eax],al
000008D1  0000              add [eax],al
000008D3  0000              add [eax],al
000008D5  0000              add [eax],al
000008D7  0000              add [eax],al
000008D9  0000              add [eax],al
000008DB  0000              add [eax],al
000008DD  0000              add [eax],al
000008DF  0000              add [eax],al
000008E1  0000              add [eax],al
000008E3  0000              add [eax],al
000008E5  0000              add [eax],al
000008E7  0000              add [eax],al
000008E9  0000              add [eax],al
000008EB  0000              add [eax],al
000008ED  0000              add [eax],al
000008EF  0000              add [eax],al
000008F1  0000              add [eax],al
000008F3  0000              add [eax],al
000008F5  0000              add [eax],al
000008F7  0000              add [eax],al
000008F9  0000              add [eax],al
000008FB  0000              add [eax],al
000008FD  0000              add [eax],al
000008FF  0000              add [eax],al
00000901  0000              add [eax],al
00000903  0000              add [eax],al
00000905  0000              add [eax],al
00000907  0000              add [eax],al
00000909  0000              add [eax],al
0000090B  0000              add [eax],al
0000090D  0000              add [eax],al
0000090F  0000              add [eax],al
00000911  0000              add [eax],al
00000913  0000              add [eax],al
00000915  0000              add [eax],al
00000917  0000              add [eax],al
00000919  0000              add [eax],al
0000091B  0000              add [eax],al
0000091D  0000              add [eax],al
0000091F  0000              add [eax],al
00000921  0000              add [eax],al
00000923  0000              add [eax],al
00000925  0000              add [eax],al
00000927  0000              add [eax],al
00000929  0000              add [eax],al
0000092B  0000              add [eax],al
0000092D  0000              add [eax],al
0000092F  0000              add [eax],al
00000931  0000              add [eax],al
00000933  0000              add [eax],al
00000935  0000              add [eax],al
00000937  0000              add [eax],al
00000939  0000              add [eax],al
0000093B  0000              add [eax],al
0000093D  0000              add [eax],al
0000093F  0000              add [eax],al
00000941  0000              add [eax],al
00000943  0000              add [eax],al
00000945  0000              add [eax],al
00000947  0000              add [eax],al
00000949  0000              add [eax],al
0000094B  0000              add [eax],al
0000094D  0000              add [eax],al
0000094F  0000              add [eax],al
00000951  0000              add [eax],al
00000953  0000              add [eax],al
00000955  0000              add [eax],al
00000957  0000              add [eax],al
00000959  0000              add [eax],al
0000095B  0000              add [eax],al
0000095D  0000              add [eax],al
0000095F  0000              add [eax],al
00000961  0000              add [eax],al
00000963  0000              add [eax],al
00000965  0000              add [eax],al
00000967  0000              add [eax],al
00000969  0000              add [eax],al
0000096B  0000              add [eax],al
0000096D  0000              add [eax],al
0000096F  0000              add [eax],al
00000971  0000              add [eax],al
00000973  0000              add [eax],al
00000975  0000              add [eax],al
00000977  0000              add [eax],al
00000979  0000              add [eax],al
0000097B  0000              add [eax],al
0000097D  0000              add [eax],al
0000097F  0000              add [eax],al
00000981  0000              add [eax],al
00000983  0000              add [eax],al
00000985  0000              add [eax],al
00000987  0000              add [eax],al
00000989  0000              add [eax],al
0000098B  0000              add [eax],al
0000098D  0000              add [eax],al
0000098F  0000              add [eax],al
00000991  0000              add [eax],al
00000993  0000              add [eax],al
00000995  0000              add [eax],al
00000997  0000              add [eax],al
00000999  0000              add [eax],al
0000099B  0000              add [eax],al
0000099D  0000              add [eax],al
0000099F  0000              add [eax],al
000009A1  0000              add [eax],al
000009A3  0000              add [eax],al
000009A5  0000              add [eax],al
000009A7  0000              add [eax],al
000009A9  0000              add [eax],al
000009AB  0000              add [eax],al
000009AD  0000              add [eax],al
000009AF  0000              add [eax],al
000009B1  0000              add [eax],al
000009B3  0000              add [eax],al
000009B5  0000              add [eax],al
000009B7  0000              add [eax],al
000009B9  0000              add [eax],al
000009BB  0000              add [eax],al
000009BD  0000              add [eax],al
000009BF  0000              add [eax],al
000009C1  0000              add [eax],al
000009C3  0000              add [eax],al
000009C5  0000              add [eax],al
000009C7  0000              add [eax],al
000009C9  0000              add [eax],al
000009CB  0000              add [eax],al
000009CD  0000              add [eax],al
000009CF  0000              add [eax],al
000009D1  0000              add [eax],al
000009D3  0000              add [eax],al
000009D5  0000              add [eax],al
000009D7  0000              add [eax],al
000009D9  0000              add [eax],al
000009DB  0000              add [eax],al
000009DD  0000              add [eax],al
000009DF  0000              add [eax],al
000009E1  0000              add [eax],al
000009E3  0000              add [eax],al
000009E5  0000              add [eax],al
000009E7  0000              add [eax],al
000009E9  0000              add [eax],al
000009EB  0000              add [eax],al
000009ED  0000              add [eax],al
000009EF  0000              add [eax],al
000009F1  0000              add [eax],al
000009F3  0000              add [eax],al
000009F5  0000              add [eax],al
000009F7  0000              add [eax],al
000009F9  0000              add [eax],al
000009FB  0000              add [eax],al
000009FD  0000              add [eax],al
000009FF  0000              add [eax],al
00000A01  0000              add [eax],al
00000A03  0000              add [eax],al
00000A05  0000              add [eax],al
00000A07  0000              add [eax],al
00000A09  0000              add [eax],al
00000A0B  0000              add [eax],al
00000A0D  0000              add [eax],al
00000A0F  0000              add [eax],al
00000A11  0000              add [eax],al
00000A13  0000              add [eax],al
00000A15  0000              add [eax],al
00000A17  0000              add [eax],al
00000A19  0000              add [eax],al
00000A1B  0000              add [eax],al
00000A1D  0000              add [eax],al
00000A1F  0000              add [eax],al
00000A21  0000              add [eax],al
00000A23  0000              add [eax],al
00000A25  0000              add [eax],al
00000A27  0000              add [eax],al
00000A29  0000              add [eax],al
00000A2B  0000              add [eax],al
00000A2D  0000              add [eax],al
00000A2F  0000              add [eax],al
00000A31  0000              add [eax],al
00000A33  0000              add [eax],al
00000A35  0000              add [eax],al
00000A37  0000              add [eax],al
00000A39  0000              add [eax],al
00000A3B  0000              add [eax],al
00000A3D  0000              add [eax],al
00000A3F  0000              add [eax],al
00000A41  0000              add [eax],al
00000A43  0000              add [eax],al
00000A45  0000              add [eax],al
00000A47  0000              add [eax],al
00000A49  0000              add [eax],al
00000A4B  0000              add [eax],al
00000A4D  0000              add [eax],al
00000A4F  0000              add [eax],al
00000A51  0000              add [eax],al
00000A53  0000              add [eax],al
00000A55  0000              add [eax],al
00000A57  0000              add [eax],al
00000A59  0000              add [eax],al
00000A5B  0000              add [eax],al
00000A5D  0000              add [eax],al
00000A5F  0000              add [eax],al
00000A61  0000              add [eax],al
00000A63  0000              add [eax],al
00000A65  0000              add [eax],al
00000A67  0000              add [eax],al
00000A69  0000              add [eax],al
00000A6B  0000              add [eax],al
00000A6D  0000              add [eax],al
00000A6F  0000              add [eax],al
00000A71  0000              add [eax],al
00000A73  0000              add [eax],al
00000A75  0000              add [eax],al
00000A77  0000              add [eax],al
00000A79  0000              add [eax],al
00000A7B  0000              add [eax],al
00000A7D  0000              add [eax],al
00000A7F  0000              add [eax],al
00000A81  0000              add [eax],al
00000A83  0000              add [eax],al
00000A85  0000              add [eax],al
00000A87  0000              add [eax],al
00000A89  0000              add [eax],al
00000A8B  0000              add [eax],al
00000A8D  0000              add [eax],al
00000A8F  0000              add [eax],al
00000A91  0000              add [eax],al
00000A93  0000              add [eax],al
00000A95  0000              add [eax],al
00000A97  0000              add [eax],al
00000A99  0000              add [eax],al
00000A9B  0000              add [eax],al
00000A9D  0000              add [eax],al
00000A9F  0000              add [eax],al
00000AA1  0000              add [eax],al
00000AA3  0000              add [eax],al
00000AA5  0000              add [eax],al
00000AA7  0000              add [eax],al
00000AA9  0000              add [eax],al
00000AAB  0000              add [eax],al
00000AAD  0000              add [eax],al
00000AAF  0000              add [eax],al
00000AB1  0000              add [eax],al
00000AB3  0000              add [eax],al
00000AB5  0000              add [eax],al
00000AB7  0000              add [eax],al
00000AB9  0000              add [eax],al
00000ABB  0000              add [eax],al
00000ABD  0000              add [eax],al
00000ABF  0000              add [eax],al
00000AC1  0000              add [eax],al
00000AC3  0000              add [eax],al
00000AC5  0000              add [eax],al
00000AC7  0000              add [eax],al
00000AC9  0000              add [eax],al
00000ACB  0000              add [eax],al
00000ACD  0000              add [eax],al
00000ACF  0000              add [eax],al
00000AD1  0000              add [eax],al
00000AD3  0000              add [eax],al
00000AD5  0000              add [eax],al
00000AD7  0000              add [eax],al
00000AD9  0000              add [eax],al
00000ADB  0000              add [eax],al
00000ADD  0000              add [eax],al
00000ADF  0000              add [eax],al
00000AE1  0000              add [eax],al
00000AE3  0000              add [eax],al
00000AE5  0000              add [eax],al
00000AE7  0000              add [eax],al
00000AE9  0000              add [eax],al
00000AEB  0000              add [eax],al
00000AED  0000              add [eax],al
00000AEF  0000              add [eax],al
00000AF1  0000              add [eax],al
00000AF3  0000              add [eax],al
00000AF5  0000              add [eax],al
00000AF7  0000              add [eax],al
00000AF9  0000              add [eax],al
00000AFB  0000              add [eax],al
00000AFD  0000              add [eax],al
00000AFF  0000              add [eax],al
00000B01  0000              add [eax],al
00000B03  0000              add [eax],al
00000B05  0000              add [eax],al
00000B07  0000              add [eax],al
00000B09  0000              add [eax],al
00000B0B  0000              add [eax],al
00000B0D  0000              add [eax],al
00000B0F  0000              add [eax],al
00000B11  0000              add [eax],al
00000B13  0000              add [eax],al
00000B15  0000              add [eax],al
00000B17  0000              add [eax],al
00000B19  0000              add [eax],al
00000B1B  0000              add [eax],al
00000B1D  0000              add [eax],al
00000B1F  0000              add [eax],al
00000B21  0000              add [eax],al
00000B23  0000              add [eax],al
00000B25  0000              add [eax],al
00000B27  0000              add [eax],al
00000B29  0000              add [eax],al
00000B2B  0000              add [eax],al
00000B2D  0000              add [eax],al
00000B2F  0000              add [eax],al
00000B31  0000              add [eax],al
00000B33  0000              add [eax],al
00000B35  0000              add [eax],al
00000B37  0000              add [eax],al
00000B39  0000              add [eax],al
00000B3B  0000              add [eax],al
00000B3D  0000              add [eax],al
00000B3F  0000              add [eax],al
00000B41  0000              add [eax],al
00000B43  0000              add [eax],al
00000B45  0000              add [eax],al
00000B47  0000              add [eax],al
00000B49  0000              add [eax],al
00000B4B  0000              add [eax],al
00000B4D  0000              add [eax],al
00000B4F  0000              add [eax],al
00000B51  0000              add [eax],al
00000B53  0000              add [eax],al
00000B55  0000              add [eax],al
00000B57  0000              add [eax],al
00000B59  0000              add [eax],al
00000B5B  0000              add [eax],al
00000B5D  0000              add [eax],al
00000B5F  0000              add [eax],al
00000B61  0000              add [eax],al
00000B63  0000              add [eax],al
00000B65  0000              add [eax],al
00000B67  0000              add [eax],al
00000B69  0000              add [eax],al
00000B6B  0000              add [eax],al
00000B6D  0000              add [eax],al
00000B6F  0000              add [eax],al
00000B71  0000              add [eax],al
00000B73  0000              add [eax],al
00000B75  0000              add [eax],al
00000B77  0000              add [eax],al
00000B79  0000              add [eax],al
00000B7B  0000              add [eax],al
00000B7D  0000              add [eax],al
00000B7F  0000              add [eax],al
00000B81  0000              add [eax],al
00000B83  0000              add [eax],al
00000B85  0000              add [eax],al
00000B87  0000              add [eax],al
00000B89  0000              add [eax],al
00000B8B  0000              add [eax],al
00000B8D  0000              add [eax],al
00000B8F  0000              add [eax],al
00000B91  0000              add [eax],al
00000B93  0000              add [eax],al
00000B95  0000              add [eax],al
00000B97  0000              add [eax],al
00000B99  0000              add [eax],al
00000B9B  0000              add [eax],al
00000B9D  0000              add [eax],al
00000B9F  0000              add [eax],al
00000BA1  0000              add [eax],al
00000BA3  0000              add [eax],al
00000BA5  0000              add [eax],al
00000BA7  0000              add [eax],al
00000BA9  0000              add [eax],al
00000BAB  0000              add [eax],al
00000BAD  0000              add [eax],al
00000BAF  0000              add [eax],al
00000BB1  0000              add [eax],al
00000BB3  0000              add [eax],al
00000BB5  0000              add [eax],al
00000BB7  0000              add [eax],al
00000BB9  0000              add [eax],al
00000BBB  0000              add [eax],al
00000BBD  0000              add [eax],al
00000BBF  0000              add [eax],al
00000BC1  0000              add [eax],al
00000BC3  0000              add [eax],al
00000BC5  0000              add [eax],al
00000BC7  0000              add [eax],al
00000BC9  0000              add [eax],al
00000BCB  0000              add [eax],al
00000BCD  0000              add [eax],al
00000BCF  0000              add [eax],al
00000BD1  0000              add [eax],al
00000BD3  0000              add [eax],al
00000BD5  0000              add [eax],al
00000BD7  0000              add [eax],al
00000BD9  0000              add [eax],al
00000BDB  0000              add [eax],al
00000BDD  0000              add [eax],al
00000BDF  0000              add [eax],al
00000BE1  0000              add [eax],al
00000BE3  0000              add [eax],al
00000BE5  0000              add [eax],al
00000BE7  0000              add [eax],al
00000BE9  0000              add [eax],al
00000BEB  0000              add [eax],al
00000BED  0000              add [eax],al
00000BEF  0000              add [eax],al
00000BF1  0000              add [eax],al
00000BF3  0000              add [eax],al
00000BF5  0000              add [eax],al
00000BF7  0000              add [eax],al
00000BF9  0000              add [eax],al
00000BFB  0000              add [eax],al
00000BFD  0000              add [eax],al
00000BFF  0000              add [eax],al
00000C01  0000              add [eax],al
00000C03  0000              add [eax],al
00000C05  0000              add [eax],al
00000C07  0000              add [eax],al
00000C09  0000              add [eax],al
00000C0B  0000              add [eax],al
00000C0D  0000              add [eax],al
00000C0F  0000              add [eax],al
00000C11  0000              add [eax],al
00000C13  0000              add [eax],al
00000C15  0000              add [eax],al
00000C17  0000              add [eax],al
00000C19  0000              add [eax],al
00000C1B  0000              add [eax],al
00000C1D  0000              add [eax],al
00000C1F  0000              add [eax],al
00000C21  0000              add [eax],al
00000C23  0000              add [eax],al
00000C25  0000              add [eax],al
00000C27  0000              add [eax],al
00000C29  0000              add [eax],al
00000C2B  0000              add [eax],al
00000C2D  0000              add [eax],al
00000C2F  0000              add [eax],al
00000C31  0000              add [eax],al
00000C33  0000              add [eax],al
00000C35  0000              add [eax],al
00000C37  0000              add [eax],al
00000C39  0000              add [eax],al
00000C3B  0000              add [eax],al
00000C3D  0000              add [eax],al
00000C3F  0000              add [eax],al
00000C41  0000              add [eax],al
00000C43  0000              add [eax],al
00000C45  0000              add [eax],al
00000C47  0000              add [eax],al
00000C49  0000              add [eax],al
00000C4B  0000              add [eax],al
00000C4D  0000              add [eax],al
00000C4F  0000              add [eax],al
00000C51  0000              add [eax],al
00000C53  0000              add [eax],al
00000C55  0000              add [eax],al
00000C57  0000              add [eax],al
00000C59  0000              add [eax],al
00000C5B  0000              add [eax],al
00000C5D  0000              add [eax],al
00000C5F  0000              add [eax],al
00000C61  0000              add [eax],al
00000C63  0000              add [eax],al
00000C65  0000              add [eax],al
00000C67  0000              add [eax],al
00000C69  0000              add [eax],al
00000C6B  0000              add [eax],al
00000C6D  0000              add [eax],al
00000C6F  0000              add [eax],al
00000C71  0000              add [eax],al
00000C73  0000              add [eax],al
00000C75  0000              add [eax],al
00000C77  0000              add [eax],al
00000C79  0000              add [eax],al
00000C7B  0000              add [eax],al
00000C7D  0000              add [eax],al
00000C7F  0000              add [eax],al
00000C81  0000              add [eax],al
00000C83  0000              add [eax],al
00000C85  0000              add [eax],al
00000C87  0000              add [eax],al
00000C89  0000              add [eax],al
00000C8B  0000              add [eax],al
00000C8D  0000              add [eax],al
00000C8F  0000              add [eax],al
00000C91  0000              add [eax],al
00000C93  0000              add [eax],al
00000C95  0000              add [eax],al
00000C97  0000              add [eax],al
00000C99  0000              add [eax],al
00000C9B  0000              add [eax],al
00000C9D  0000              add [eax],al
00000C9F  0000              add [eax],al
00000CA1  0000              add [eax],al
00000CA3  0000              add [eax],al
00000CA5  0000              add [eax],al
00000CA7  0000              add [eax],al
00000CA9  0000              add [eax],al
00000CAB  0000              add [eax],al
00000CAD  0000              add [eax],al
00000CAF  0000              add [eax],al
00000CB1  0000              add [eax],al
00000CB3  0000              add [eax],al
00000CB5  0000              add [eax],al
00000CB7  0000              add [eax],al
00000CB9  0000              add [eax],al
00000CBB  0000              add [eax],al
00000CBD  0000              add [eax],al
00000CBF  0000              add [eax],al
00000CC1  0000              add [eax],al
00000CC3  0000              add [eax],al
00000CC5  0000              add [eax],al
00000CC7  0000              add [eax],al
00000CC9  0000              add [eax],al
00000CCB  0000              add [eax],al
00000CCD  0000              add [eax],al
00000CCF  0000              add [eax],al
00000CD1  0000              add [eax],al
00000CD3  0000              add [eax],al
00000CD5  0000              add [eax],al
00000CD7  0000              add [eax],al
00000CD9  0000              add [eax],al
00000CDB  0000              add [eax],al
00000CDD  0000              add [eax],al
00000CDF  0000              add [eax],al
00000CE1  0000              add [eax],al
00000CE3  0000              add [eax],al
00000CE5  0000              add [eax],al
00000CE7  0000              add [eax],al
00000CE9  0000              add [eax],al
00000CEB  0000              add [eax],al
00000CED  0000              add [eax],al
00000CEF  0000              add [eax],al
00000CF1  0000              add [eax],al
00000CF3  0000              add [eax],al
00000CF5  0000              add [eax],al
00000CF7  0000              add [eax],al
00000CF9  0000              add [eax],al
00000CFB  0000              add [eax],al
00000CFD  0000              add [eax],al
00000CFF  0000              add [eax],al
00000D01  0000              add [eax],al
00000D03  0000              add [eax],al
00000D05  0000              add [eax],al
00000D07  0000              add [eax],al
00000D09  0000              add [eax],al
00000D0B  0000              add [eax],al
00000D0D  0000              add [eax],al
00000D0F  0000              add [eax],al
00000D11  0000              add [eax],al
00000D13  0000              add [eax],al
00000D15  0000              add [eax],al
00000D17  0000              add [eax],al
00000D19  0000              add [eax],al
00000D1B  0000              add [eax],al
00000D1D  0000              add [eax],al
00000D1F  0000              add [eax],al
00000D21  0000              add [eax],al
00000D23  0000              add [eax],al
00000D25  0000              add [eax],al
00000D27  0000              add [eax],al
00000D29  0000              add [eax],al
00000D2B  0000              add [eax],al
00000D2D  0000              add [eax],al
00000D2F  0000              add [eax],al
00000D31  0000              add [eax],al
00000D33  0000              add [eax],al
00000D35  0000              add [eax],al
00000D37  0000              add [eax],al
00000D39  0000              add [eax],al
00000D3B  0000              add [eax],al
00000D3D  0000              add [eax],al
00000D3F  0000              add [eax],al
00000D41  0000              add [eax],al
00000D43  0000              add [eax],al
00000D45  0000              add [eax],al
00000D47  0000              add [eax],al
00000D49  0000              add [eax],al
00000D4B  0000              add [eax],al
00000D4D  0000              add [eax],al
00000D4F  0000              add [eax],al
00000D51  0000              add [eax],al
00000D53  0000              add [eax],al
00000D55  0000              add [eax],al
00000D57  0000              add [eax],al
00000D59  0000              add [eax],al
00000D5B  0000              add [eax],al
00000D5D  0000              add [eax],al
00000D5F  0000              add [eax],al
00000D61  0000              add [eax],al
00000D63  0000              add [eax],al
00000D65  0000              add [eax],al
00000D67  0000              add [eax],al
00000D69  0000              add [eax],al
00000D6B  0000              add [eax],al
00000D6D  0000              add [eax],al
00000D6F  0000              add [eax],al
00000D71  0000              add [eax],al
00000D73  0000              add [eax],al
00000D75  0000              add [eax],al
00000D77  0000              add [eax],al
00000D79  0000              add [eax],al
00000D7B  0000              add [eax],al
00000D7D  0000              add [eax],al
00000D7F  0000              add [eax],al
00000D81  0000              add [eax],al
00000D83  0000              add [eax],al
00000D85  0000              add [eax],al
00000D87  0000              add [eax],al
00000D89  0000              add [eax],al
00000D8B  0000              add [eax],al
00000D8D  0000              add [eax],al
00000D8F  0000              add [eax],al
00000D91  0000              add [eax],al
00000D93  0000              add [eax],al
00000D95  0000              add [eax],al
00000D97  0000              add [eax],al
00000D99  0000              add [eax],al
00000D9B  0000              add [eax],al
00000D9D  0000              add [eax],al
00000D9F  0000              add [eax],al
00000DA1  0000              add [eax],al
00000DA3  0000              add [eax],al
00000DA5  0000              add [eax],al
00000DA7  0000              add [eax],al
00000DA9  0000              add [eax],al
00000DAB  0000              add [eax],al
00000DAD  0000              add [eax],al
00000DAF  0000              add [eax],al
00000DB1  0000              add [eax],al
00000DB3  0000              add [eax],al
00000DB5  0000              add [eax],al
00000DB7  0000              add [eax],al
00000DB9  0000              add [eax],al
00000DBB  0000              add [eax],al
00000DBD  0000              add [eax],al
00000DBF  0000              add [eax],al
00000DC1  0000              add [eax],al
00000DC3  0000              add [eax],al
00000DC5  0000              add [eax],al
00000DC7  0000              add [eax],al
00000DC9  0000              add [eax],al
00000DCB  0000              add [eax],al
00000DCD  0000              add [eax],al
00000DCF  0000              add [eax],al
00000DD1  0000              add [eax],al
00000DD3  0000              add [eax],al
00000DD5  0000              add [eax],al
00000DD7  0000              add [eax],al
00000DD9  0000              add [eax],al
00000DDB  0000              add [eax],al
00000DDD  0000              add [eax],al
00000DDF  0000              add [eax],al
00000DE1  0000              add [eax],al
00000DE3  0000              add [eax],al
00000DE5  0000              add [eax],al
00000DE7  0000              add [eax],al
00000DE9  0000              add [eax],al
00000DEB  0000              add [eax],al
00000DED  0000              add [eax],al
00000DEF  0000              add [eax],al
00000DF1  0000              add [eax],al
00000DF3  0000              add [eax],al
00000DF5  0000              add [eax],al
00000DF7  0000              add [eax],al
00000DF9  0000              add [eax],al
00000DFB  0000              add [eax],al
00000DFD  0000              add [eax],al
00000DFF  0000              add [eax],al
00000E01  0000              add [eax],al
00000E03  0000              add [eax],al
00000E05  0000              add [eax],al
00000E07  0000              add [eax],al
00000E09  0000              add [eax],al
00000E0B  0000              add [eax],al
00000E0D  0000              add [eax],al
00000E0F  0000              add [eax],al
00000E11  0000              add [eax],al
00000E13  0000              add [eax],al
00000E15  0000              add [eax],al
00000E17  0000              add [eax],al
00000E19  0000              add [eax],al
00000E1B  0000              add [eax],al
00000E1D  0000              add [eax],al
00000E1F  0000              add [eax],al
00000E21  0000              add [eax],al
00000E23  0000              add [eax],al
00000E25  0000              add [eax],al
00000E27  0000              add [eax],al
00000E29  0000              add [eax],al
00000E2B  0000              add [eax],al
00000E2D  0000              add [eax],al
00000E2F  0000              add [eax],al
00000E31  0000              add [eax],al
00000E33  0000              add [eax],al
00000E35  0000              add [eax],al
00000E37  0000              add [eax],al
00000E39  0000              add [eax],al
00000E3B  0000              add [eax],al
00000E3D  0000              add [eax],al
00000E3F  0000              add [eax],al
00000E41  0000              add [eax],al
00000E43  0000              add [eax],al
00000E45  0000              add [eax],al
00000E47  0000              add [eax],al
00000E49  0000              add [eax],al
00000E4B  0000              add [eax],al
00000E4D  0000              add [eax],al
00000E4F  0000              add [eax],al
00000E51  0000              add [eax],al
00000E53  0000              add [eax],al
00000E55  0000              add [eax],al
00000E57  0000              add [eax],al
00000E59  0000              add [eax],al
00000E5B  0000              add [eax],al
00000E5D  0000              add [eax],al
00000E5F  0000              add [eax],al
00000E61  0000              add [eax],al
00000E63  0000              add [eax],al
00000E65  0000              add [eax],al
00000E67  0000              add [eax],al
00000E69  0000              add [eax],al
00000E6B  0000              add [eax],al
00000E6D  0000              add [eax],al
00000E6F  0000              add [eax],al
00000E71  0000              add [eax],al
00000E73  0000              add [eax],al
00000E75  0000              add [eax],al
00000E77  0000              add [eax],al
00000E79  0000              add [eax],al
00000E7B  0000              add [eax],al
00000E7D  0000              add [eax],al
00000E7F  0000              add [eax],al
00000E81  0000              add [eax],al
00000E83  0000              add [eax],al
00000E85  0000              add [eax],al
00000E87  0000              add [eax],al
00000E89  0000              add [eax],al
00000E8B  0000              add [eax],al
00000E8D  0000              add [eax],al
00000E8F  0000              add [eax],al
00000E91  0000              add [eax],al
00000E93  0000              add [eax],al
00000E95  0000              add [eax],al
00000E97  0000              add [eax],al
00000E99  0000              add [eax],al
00000E9B  0000              add [eax],al
00000E9D  0000              add [eax],al
00000E9F  0000              add [eax],al
00000EA1  0000              add [eax],al
00000EA3  0000              add [eax],al
00000EA5  0000              add [eax],al
00000EA7  0000              add [eax],al
00000EA9  0000              add [eax],al
00000EAB  0000              add [eax],al
00000EAD  0000              add [eax],al
00000EAF  0000              add [eax],al
00000EB1  0000              add [eax],al
00000EB3  0000              add [eax],al
00000EB5  0000              add [eax],al
00000EB7  0000              add [eax],al
00000EB9  0000              add [eax],al
00000EBB  0000              add [eax],al
00000EBD  0000              add [eax],al
00000EBF  0000              add [eax],al
00000EC1  0000              add [eax],al
00000EC3  0000              add [eax],al
00000EC5  0000              add [eax],al
00000EC7  0000              add [eax],al
00000EC9  0000              add [eax],al
00000ECB  0000              add [eax],al
00000ECD  0000              add [eax],al
00000ECF  0000              add [eax],al
00000ED1  0000              add [eax],al
00000ED3  0000              add [eax],al
00000ED5  0000              add [eax],al
00000ED7  0000              add [eax],al
00000ED9  0000              add [eax],al
00000EDB  0000              add [eax],al
00000EDD  0000              add [eax],al
00000EDF  0000              add [eax],al
00000EE1  0000              add [eax],al
00000EE3  0000              add [eax],al
00000EE5  0000              add [eax],al
00000EE7  0000              add [eax],al
00000EE9  0000              add [eax],al
00000EEB  0000              add [eax],al
00000EED  0000              add [eax],al
00000EEF  0000              add [eax],al
00000EF1  0000              add [eax],al
00000EF3  0000              add [eax],al
00000EF5  0000              add [eax],al
00000EF7  0000              add [eax],al
00000EF9  0000              add [eax],al
00000EFB  0000              add [eax],al
00000EFD  0000              add [eax],al
00000EFF  0000              add [eax],al
00000F01  0000              add [eax],al
00000F03  0000              add [eax],al
00000F05  0000              add [eax],al
00000F07  0000              add [eax],al
00000F09  0000              add [eax],al
00000F0B  0000              add [eax],al
00000F0D  0000              add [eax],al
00000F0F  0000              add [eax],al
00000F11  0000              add [eax],al
00000F13  0000              add [eax],al
00000F15  0000              add [eax],al
00000F17  0000              add [eax],al
00000F19  0000              add [eax],al
00000F1B  0000              add [eax],al
00000F1D  0000              add [eax],al
00000F1F  0000              add [eax],al
00000F21  0000              add [eax],al
00000F23  0000              add [eax],al
00000F25  0000              add [eax],al
00000F27  0000              add [eax],al
00000F29  0000              add [eax],al
00000F2B  0000              add [eax],al
00000F2D  0000              add [eax],al
00000F2F  0000              add [eax],al
00000F31  0000              add [eax],al
00000F33  0000              add [eax],al
00000F35  0000              add [eax],al
00000F37  0000              add [eax],al
00000F39  0000              add [eax],al
00000F3B  0000              add [eax],al
00000F3D  0000              add [eax],al
00000F3F  0000              add [eax],al
00000F41  0000              add [eax],al
00000F43  0000              add [eax],al
00000F45  0000              add [eax],al
00000F47  0000              add [eax],al
00000F49  0000              add [eax],al
00000F4B  0000              add [eax],al
00000F4D  0000              add [eax],al
00000F4F  0000              add [eax],al
00000F51  0000              add [eax],al
00000F53  0000              add [eax],al
00000F55  0000              add [eax],al
00000F57  0000              add [eax],al
00000F59  0000              add [eax],al
00000F5B  0000              add [eax],al
00000F5D  0000              add [eax],al
00000F5F  0000              add [eax],al
00000F61  0000              add [eax],al
00000F63  0000              add [eax],al
00000F65  0000              add [eax],al
00000F67  0000              add [eax],al
00000F69  0000              add [eax],al
00000F6B  0000              add [eax],al
00000F6D  0000              add [eax],al
00000F6F  0000              add [eax],al
00000F71  0000              add [eax],al
00000F73  0000              add [eax],al
00000F75  0000              add [eax],al
00000F77  0000              add [eax],al
00000F79  0000              add [eax],al
00000F7B  0000              add [eax],al
00000F7D  0000              add [eax],al
00000F7F  0000              add [eax],al
00000F81  0000              add [eax],al
00000F83  0000              add [eax],al
00000F85  0000              add [eax],al
00000F87  0000              add [eax],al
00000F89  0000              add [eax],al
00000F8B  0000              add [eax],al
00000F8D  0000              add [eax],al
00000F8F  0000              add [eax],al
00000F91  0000              add [eax],al
00000F93  0000              add [eax],al
00000F95  0000              add [eax],al
00000F97  0000              add [eax],al
00000F99  0000              add [eax],al
00000F9B  0000              add [eax],al
00000F9D  0000              add [eax],al
00000F9F  0000              add [eax],al
00000FA1  0000              add [eax],al
00000FA3  0000              add [eax],al
00000FA5  0000              add [eax],al
00000FA7  0000              add [eax],al
00000FA9  0000              add [eax],al
00000FAB  0000              add [eax],al
00000FAD  0000              add [eax],al
00000FAF  0000              add [eax],al
00000FB1  0000              add [eax],al
00000FB3  0000              add [eax],al
00000FB5  0000              add [eax],al
00000FB7  0000              add [eax],al
00000FB9  0000              add [eax],al
00000FBB  0000              add [eax],al
00000FBD  0000              add [eax],al
00000FBF  0000              add [eax],al
00000FC1  0000              add [eax],al
00000FC3  0000              add [eax],al
00000FC5  0000              add [eax],al
00000FC7  0000              add [eax],al
00000FC9  0000              add [eax],al
00000FCB  0000              add [eax],al
00000FCD  0000              add [eax],al
00000FCF  0000              add [eax],al
00000FD1  0000              add [eax],al
00000FD3  0000              add [eax],al
00000FD5  0000              add [eax],al
00000FD7  0000              add [eax],al
00000FD9  0000              add [eax],al
00000FDB  0000              add [eax],al
00000FDD  0000              add [eax],al
00000FDF  0000              add [eax],al
00000FE1  0000              add [eax],al
00000FE3  0000              add [eax],al
00000FE5  0000              add [eax],al
00000FE7  0000              add [eax],al
00000FE9  0000              add [eax],al
00000FEB  0000              add [eax],al
00000FED  0000              add [eax],al
00000FEF  0000              add [eax],al
00000FF1  0000              add [eax],al
00000FF3  0000              add [eax],al
00000FF5  0000              add [eax],al
00000FF7  0000              add [eax],al
00000FF9  0000              add [eax],al
00000FFB  0000              add [eax],al
00000FFD  0000              add [eax],al
00000FFF  0002              add [edx],al
00001001  B0AD              mov al,0xad
00001003  1B03              sbb eax,[ebx]
00001005  0000              add [eax],al
00001007  00FB              add bl,bh
00001009  4F                dec edi
0000100A  52                push edx
0000100B  E466              in al,0x66
0000100D  90                nop
0000100E  6690              xchg ax,ax
00001010  BC707A1000        mov esp,0x107a70
00001015  E8460A0000        call dword 0x1a60
0000101A  FA                cli
0000101B  F4                hlt
0000101C  EBFD              jmp short 0x101b
0000101E  B0FF              mov al,0xff
00001020  E6A1              out 0xa1,al
00001022  E621              out 0x21,al
00001024  C3                ret
00001025  0000              add [eax],al
00001027  0000              add [eax],al
00001029  0000              add [eax],al
0000102B  FA                cli
0000102C  B8403A1000        mov eax,0x103a40
00001031  A327001000        mov [0x100027],eax
00001036  66B82700          mov ax,0x27
0000103A  66A325001000      mov [0x100025],ax
00001040  0F011525001000    lgdt [dword 0x100025]
00001047  EA4E0010000800    jmp dword 0x8:0x10004e
0000104E  66B81000          mov ax,0x10
00001052  8ED8              mov ds,eax
00001054  8EC0              mov es,eax
00001056  8EE0              mov fs,eax
00001058  8EE8              mov gs,eax
0000105A  8ED0              mov ss,eax
0000105C  66B81800          mov ax,0x18
00001060  0F00D8            ltr ax
00001063  C3                ret
00001064  8B442404          mov eax,[esp+0x4]
00001068  0F0100            sgdt [eax]
0000106B  C3                ret
0000106C  8B442404          mov eax,[esp+0x4]
00001070  0F0108            sidt [eax]
00001073  C3                ret
00001074  9C                pushfd
00001075  58                pop eax
00001076  C3                ret
00001077  6690              xchg ax,ax
00001079  6690              xchg ax,ax
0000107B  6690              xchg ax,ax
0000107D  6690              xchg ax,ax
0000107F  90                nop
00001080  57                push edi
00001081  56                push esi
00001082  53                push ebx
00001083  83EC10            sub esp,byte +0x10
00001086  8B7C2424          mov edi,[esp+0x24]
0000108A  8B4C2420          mov ecx,[esp+0x20]
0000108E  8B07              mov eax,[edi]
00001090  8B5F04            mov ebx,[edi+0x4]
00001093  89C6              mov esi,eax
00001095  89DA              mov edx,ebx
00001097  0FB7DB            movzx ebx,bx
0000109A  81E200000F00      and edx,0xf0000
000010A0  81E6000000FF      and esi,0xff000000
000010A6  09D6              or esi,edx
000010A8  8B5708            mov edx,[edi+0x8]
000010AB  C1E208            shl edx,byte 0x8
000010AE  81E200FFF000      and edx,0xf0ff00
000010B4  89D7              mov edi,edx
000010B6  09F7              or edi,esi
000010B8  89C6              mov esi,eax
000010BA  C1E010            shl eax,byte 0x10
000010BD  C1EE10            shr esi,byte 0x10
000010C0  09D8              or eax,ebx
000010C2  89F2              mov edx,esi
000010C4  89442408          mov [esp+0x8],eax
000010C8  31C0              xor eax,eax
000010CA  0FB6F2            movzx esi,dl
000010CD  09F7              or edi,esi
000010CF  897C240C          mov [esp+0xc],edi
000010D3  8DB600000000      lea esi,[esi+0x0]
000010D9  8DBC2700000000    lea edi,[edi+0x0]
000010E0  0FB6540408        movzx edx,byte [esp+eax+0x8]
000010E5  881401            mov [ecx+eax],dl
000010E8  83C001            add eax,byte +0x1
000010EB  83F808            cmp eax,byte +0x8
000010EE  75F0              jnz 0x10e0
000010F0  83C410            add esp,byte +0x10
000010F3  5B                pop ebx
000010F4  5E                pop esi
000010F5  5F                pop edi
000010F6  C3                ret
000010F7  89F6              mov esi,esi
000010F9  8DBC2700000000    lea edi,[edi+0x0]
00001100  56                push esi
00001101  53                push ebx
00001102  83EC04            sub esp,byte +0x4
00001105  8B5C2414          mov ebx,[esp+0x14]
00001109  8B742410          mov esi,[esp+0x10]
0000110D  8B4304            mov eax,[ebx+0x4]
00001110  3D00000100        cmp eax,0x10000
00001115  7625              jna 0x113c
00001117  89C2              mov edx,eax
00001119  81E2FF0F0000      and edx,0xfff
0000111F  81FAFF0F0000      cmp edx,0xfff
00001125  7469              jz 0x1190
00001127  83EC08            sub esp,byte +0x8
0000112A  6864E11000        push dword 0x10e164
0000112F  6A00              push byte +0x0
00001131  E85A130000        call dword 0x2490
00001136  8B4304            mov eax,[ebx+0x4]
00001139  83C410            add esp,byte +0x10
0000113C  3DFFFF0000        cmp eax,0xffff
00001141  774D              ja 0x1190
00001143  C6460640          mov byte [esi+0x6],0x40
00001147  B940000000        mov ecx,0x40
0000114C  8B4304            mov eax,[ebx+0x4]
0000114F  8806              mov [esi],al
00001151  8B5304            mov edx,[ebx+0x4]
00001154  C1EA08            shr edx,byte 0x8
00001157  885601            mov [esi+0x1],dl
0000115A  0FB74306          movzx eax,word [ebx+0x6]
0000115E  83E00F            and eax,byte +0xf
00001161  09C8              or eax,ecx
00001163  884606            mov [esi+0x6],al
00001166  8B03              mov eax,[ebx]
00001168  884602            mov [esi+0x2],al
0000116B  8B03              mov eax,[ebx]
0000116D  C1E808            shr eax,byte 0x8
00001170  884603            mov [esi+0x3],al
00001173  8B03              mov eax,[ebx]
00001175  C1E810            shr eax,byte 0x10
00001178  884604            mov [esi+0x4],al
0000117B  8B03              mov eax,[ebx]
0000117D  C1E818            shr eax,byte 0x18
00001180  884607            mov [esi+0x7],al
00001183  8B4308            mov eax,[ebx+0x8]
00001186  884605            mov [esi+0x5],al
00001189  83C404            add esp,byte +0x4
0000118C  5B                pop ebx
0000118D  5E                pop esi
0000118E  C3                ret
0000118F  90                nop
00001190  C1E80C            shr eax,byte 0xc
00001193  B9C0FFFFFF        mov ecx,0xffffffc0
00001198  894304            mov [ebx+0x4],eax
0000119B  C64606C0          mov byte [esi+0x6],0xc0
0000119F  EBAB              jmp short 0x114c
000011A1  EB0D              jmp short 0x11b0
000011A3  90                nop
000011A4  90                nop
000011A5  90                nop
000011A6  90                nop
000011A7  90                nop
000011A8  90                nop
000011A9  90                nop
000011AA  90                nop
000011AB  90                nop
000011AC  90                nop
000011AD  90                nop
000011AE  90                nop
000011AF  90                nop
000011B0  53                push ebx
000011B1  8B442408          mov eax,[esp+0x8]
000011B5  8B5C240C          mov ebx,[esp+0xc]
000011B9  0FB65001          movzx edx,byte [eax+0x1]
000011BD  0FB608            movzx ecx,byte [eax]
000011C0  C1E208            shl edx,byte 0x8
000011C3  09CA              or edx,ecx
000011C5  80780600          cmp byte [eax+0x6],0x0
000011C9  7909              jns 0x11d4
000011CB  C1E20C            shl edx,byte 0xc
000011CE  81CAFF0F0000      or edx,0xfff
000011D4  895304            mov [ebx+0x4],edx
000011D7  0FB65003          movzx edx,byte [eax+0x3]
000011DB  89D1              mov ecx,edx
000011DD  0FB65004          movzx edx,byte [eax+0x4]
000011E1  C1E108            shl ecx,byte 0x8
000011E4  C1E210            shl edx,byte 0x10
000011E7  09CA              or edx,ecx
000011E9  0FB64802          movzx ecx,byte [eax+0x2]
000011ED  09CA              or edx,ecx
000011EF  0FB64807          movzx ecx,byte [eax+0x7]
000011F3  C1E118            shl ecx,byte 0x18
000011F6  09CA              or edx,ecx
000011F8  8913              mov [ebx],edx
000011FA  0FB64005          movzx eax,byte [eax+0x5]
000011FE  894308            mov [ebx+0x8],eax
00001201  5B                pop ebx
00001202  C3                ret
00001203  8DB600000000      lea esi,[esi+0x0]
00001209  8DBC2700000000    lea edi,[edi+0x0]
00001210  53                push ebx
00001211  83EC1C            sub esp,byte +0x1c
00001214  6A64              push byte +0x64
00001216  6A00              push byte +0x0
00001218  6800201000        push dword 0x102000
0000121D  E8CE0E0000        call dword 0x20f0
00001222  83C40C            add esp,byte +0xc
00001225  6A28              push byte +0x28
00001227  6A00              push byte +0x0
00001229  68403A1000        push dword 0x103a40
0000122E  E8BD0E0000        call dword 0x20f0
00001233  C744241400000000  mov dword [esp+0x14],0x0
0000123B  C744241800000000  mov dword [esp+0x18],0x0
00001243  C744241C00000000  mov dword [esp+0x1c],0x0
0000124B  58                pop eax
0000124C  5A                pop edx
0000124D  8D5C240C          lea ebx,[esp+0xc]
00001251  53                push ebx
00001252  68403A1000        push dword 0x103a40
00001257  E8A4FEFFFF        call dword 0x1100
0000125C  C744241400000000  mov dword [esp+0x14],0x0
00001264  C7442418FFFFFFFF  mov dword [esp+0x18],0xffffffff
0000126C  C744241C9A000000  mov dword [esp+0x1c],0x9a
00001274  59                pop ecx
00001275  58                pop eax
00001276  53                push ebx
00001277  68483A1000        push dword 0x103a48
0000127C  E87FFEFFFF        call dword 0x1100
00001281  C744241400000000  mov dword [esp+0x14],0x0
00001289  C7442418FFFFFFFF  mov dword [esp+0x18],0xffffffff
00001291  C744241C92000000  mov dword [esp+0x1c],0x92
00001299  58                pop eax
0000129A  5A                pop edx
0000129B  53                push ebx
0000129C  68503A1000        push dword 0x103a50
000012A1  E85AFEFFFF        call dword 0x1100
000012A6  C744241400201000  mov dword [esp+0x14],0x102000
000012AE  C744241864000000  mov dword [esp+0x18],0x64
000012B6  C744241C89000000  mov dword [esp+0x1c],0x89
000012BE  59                pop ecx
000012BF  58                pop eax
000012C0  53                push ebx
000012C1  68583A1000        push dword 0x103a58
000012C6  E835FEFFFF        call dword 0x1100
000012CB  C744241400000000  mov dword [esp+0x14],0x0
000012D3  C7442418FFFFFFFF  mov dword [esp+0x18],0xffffffff
000012DB  C744241C89000000  mov dword [esp+0x1c],0x89
000012E3  58                pop eax
000012E4  5A                pop edx
000012E5  53                push ebx
000012E6  68603A1000        push dword 0x103a60
000012EB  E810FEFFFF        call dword 0x1100
000012F0  0FB605653A1000    movzx eax,byte [dword 0x103a65]
000012F7  800D663A100040    or byte [dword 0x103a66],0x40
000012FE  83E080            and eax,byte -0x80
00001301  83C81E            or eax,byte +0x1e
00001304  A2653A1000        mov [0x103a65],al
00001309  E81DFDFFFF        call dword 0x102b
0000130E  83C428            add esp,byte +0x28
00001311  5B                pop ebx
00001312  C3                ret
00001313  6690              xchg ax,ax
00001315  6690              xchg ax,ax
00001317  6690              xchg ax,ax
00001319  6690              xchg ax,ax
0000131B  6690              xchg ax,ax
0000131D  6690              xchg ax,ax
0000131F  90                nop
00001320  83EC18            sub esp,byte +0x18
00001323  6877E11000        push dword 0x10e177
00001328  E8B3110000        call dword 0x24e0
0000132D  83C410            add esp,byte +0x10
00001330  BAFFFFFFFF        mov edx,0xffffffff
00001335  8D742600          lea esi,[esi+0x0]
00001339  8DBC2700000000    lea edi,[edi+0x0]
00001340  A164201000        mov eax,[0x102064]
00001345  39C2              cmp edx,eax
00001347  74F7              jz 0x1340
00001349  8B0D00311000      mov ecx,[dword 0x103100]
0000134F  8B1580201000      mov edx,[dword 0x102080]
00001355  A164201000        mov eax,[0x102064]
0000135A  51                push ecx
0000135B  52                push edx
0000135C  50                push eax
0000135D  68ECEF1000        push dword 0x10efec
00001362  E879110000        call dword 0x24e0
00001367  8B1564201000      mov edx,[dword 0x102064]
0000136D  83C410            add esp,byte +0x10
00001370  EBCE              jmp short 0x1340
00001372  8DB42600000000    lea esi,[esi+0x0]
00001379  8DBC2700000000    lea edi,[edi+0x0]
00001380  55                push ebp
00001381  57                push edi
00001382  56                push esi
00001383  53                push ebx
00001384  83EC48            sub esp,byte +0x48
00001387  6818F01000        push dword 0x10f018
0000138C  E82F160000        call dword 0x29c0
00001391  0F20C3            mov ebx,cr0
00001394  83E301            and ebx,byte +0x1
00001397  C704247EE11000    mov dword [esp],0x10e17e
0000139E  E81D160000        call dword 0x29c0
000013A3  891C24            mov [esp],ebx
000013A6  E8150E0000        call dword 0x21c0
000013AB  C704243B000000    mov dword [esp],0x3b
000013B2  E8A9140000        call dword 0x2860
000013B7  C704240A000000    mov dword [esp],0xa
000013BE  E89D140000        call dword 0x2860
000013C3  C7042484E11000    mov dword [esp],0x10e184
000013CA  E8F1150000        call dword 0x29c0
000013CF  668CD0            mov ax,ss
000013D2  0FB7C0            movzx eax,ax
000013D5  890424            mov [esp],eax
000013D8  E8E30D0000        call dword 0x21c0
000013DD  C704243B000000    mov dword [esp],0x3b
000013E4  E877140000        call dword 0x2860
000013E9  C704240A000000    mov dword [esp],0xa
000013F0  E86B140000        call dword 0x2860
000013F5  C7042489E11000    mov dword [esp],0x10e189
000013FC  E8BF150000        call dword 0x29c0
00001401  668CD8            mov ax,ds
00001404  0FB7C0            movzx eax,ax
00001407  890424            mov [esp],eax
0000140A  E8B10D0000        call dword 0x21c0
0000140F  C704243B000000    mov dword [esp],0x3b
00001416  E845140000        call dword 0x2860
0000141B  C704240A000000    mov dword [esp],0xa
00001422  E839140000        call dword 0x2860
00001427  C704248EE11000    mov dword [esp],0x10e18e
0000142E  E88D150000        call dword 0x29c0
00001433  668CC8            mov ax,cs
00001436  0FB7C0            movzx eax,ax
00001439  31ED              xor ebp,ebp
0000143B  890424            mov [esp],eax
0000143E  E87D0D0000        call dword 0x21c0
00001443  C704243B000000    mov dword [esp],0x3b
0000144A  E811140000        call dword 0x2860
0000144F  C704240A000000    mov dword [esp],0xa
00001456  E805140000        call dword 0x2860
0000145B  31C0              xor eax,eax
0000145D  66896C2432        mov [esp+0x32],bp
00001462  6689442430        mov [esp+0x30],ax
00001467  31C0              xor eax,eax
00001469  668944242E        mov [esp+0x2e],ax
0000146E  31C0              xor eax,eax
00001470  668944242C        mov [esp+0x2c],ax
00001475  58                pop eax
00001476  8D742428          lea esi,[esp+0x28]
0000147A  56                push esi
0000147B  E8E4FBFFFF        call dword 0x1064
00001480  0FBF442430        movsx eax,word [esp+0x30]
00001485  0FBF5C242E        movsx ebx,word [esp+0x2e]
0000148A  C704240A000000    mov dword [esp],0xa
00001491  C1E010            shl eax,byte 0x10
00001494  09C3              or ebx,eax
00001496  E8C5130000        call dword 0x2860
0000149B  0FBF44242C        movsx eax,word [esp+0x2c]
000014A0  8D7B08            lea edi,[ebx+0x8]
000014A3  89FD              mov ebp,edi
000014A5  890424            mov [esp],eax
000014A8  E8130D0000        call dword 0x21c0
000014AD  C704240A000000    mov dword [esp],0xa
000014B4  E8A7130000        call dword 0x2860
000014B9  0FBF44242E        movsx eax,word [esp+0x2e]
000014BE  890424            mov [esp],eax
000014C1  E8FA0C0000        call dword 0x21c0
000014C6  C704240A000000    mov dword [esp],0xa
000014CD  E88E130000        call dword 0x2860
000014D2  0FBF442430        movsx eax,word [esp+0x30]
000014D7  890424            mov [esp],eax
000014DA  E8E10C0000        call dword 0x21c0
000014DF  C704240A000000    mov dword [esp],0xa
000014E6  E875130000        call dword 0x2860
000014EB  0FBF442432        movsx eax,word [esp+0x32]
000014F0  890424            mov [esp],eax
000014F3  E8C80C0000        call dword 0x21c0
000014F8  C704240A000000    mov dword [esp],0xa
000014FF  E85C130000        call dword 0x2860
00001504  C704240A000000    mov dword [esp],0xa
0000150B  E850130000        call dword 0x2860
00001510  8B1568D11000      mov edx,[dword 0x10d168]
00001516  A100311000        mov eax,[0x103100]
0000151B  83C40C            add esp,byte +0xc
0000151E  52                push edx
0000151F  50                push eax
00001520  6893E11000        push dword 0x10e193
00001525  E8B60F0000        call dword 0x24e0
0000152A  83C40C            add esp,byte +0xc
0000152D  68403A1000        push dword 0x103a40
00001532  53                push ebx
00001533  68A3E11000        push dword 0x10e1a3
00001538  E8A30F0000        call dword 0x24e0
0000153D  8D4328            lea eax,[ebx+0x28]
00001540  8944241C          mov [esp+0x1c],eax
00001544  83C410            add esp,byte +0x10
00001547  0FB64507          movzx eax,byte [ebp+0x7]
0000154B  83EC08            sub esp,byte +0x8
0000154E  83C508            add ebp,byte +0x8
00001551  50                push eax
00001552  0FB645FE          movzx eax,byte [ebp-0x2]
00001556  C0E807            shr al,byte 0x7
00001559  0FB6C0            movzx eax,al
0000155C  50                push eax
0000155D  0FB645FE          movzx eax,byte [ebp-0x2]
00001561  C0E806            shr al,byte 0x6
00001564  83E001            and eax,byte +0x1
00001567  50                push eax
00001568  0FB645FE          movzx eax,byte [ebp-0x2]
0000156C  C0E805            shr al,byte 0x5
0000156F  83E001            and eax,byte +0x1
00001572  50                push eax
00001573  0FB645FE          movzx eax,byte [ebp-0x2]
00001577  C0E804            shr al,byte 0x4
0000157A  83E001            and eax,byte +0x1
0000157D  50                push eax
0000157E  0FB645FE          movzx eax,byte [ebp-0x2]
00001582  83E00F            and eax,byte +0xf
00001585  50                push eax
00001586  0FB645FD          movzx eax,byte [ebp-0x3]
0000158A  C0E807            shr al,byte 0x7
0000158D  0FB6C0            movzx eax,al
00001590  50                push eax
00001591  0FB645FD          movzx eax,byte [ebp-0x3]
00001595  C0E805            shr al,byte 0x5
00001598  83E003            and eax,byte +0x3
0000159B  50                push eax
0000159C  0FB645FD          movzx eax,byte [ebp-0x3]
000015A0  C0E804            shr al,byte 0x4
000015A3  83E001            and eax,byte +0x1
000015A6  50                push eax
000015A7  0FB645FD          movzx eax,byte [ebp-0x3]
000015AB  83E00F            and eax,byte +0xf
000015AE  50                push eax
000015AF  0FB645FC          movzx eax,byte [ebp-0x4]
000015B3  50                push eax
000015B4  0FB745FA          movzx eax,word [ebp-0x6]
000015B8  50                push eax
000015B9  0FB745F8          movzx eax,word [ebp-0x8]
000015BD  50                push eax
000015BE  6844F01000        push dword 0x10f044
000015C3  E8180F0000        call dword 0x24e0
000015C8  83C440            add esp,byte +0x40
000015CB  3B6C240C          cmp ebp,[esp+0xc]
000015CF  0F8572FFFFFF      jnz dword 0x1547
000015D5  83EC0C            sub esp,byte +0xc
000015D8  68D6E21000        push dword 0x10e2d6
000015DD  E8FE0E0000        call dword 0x24e0
000015E2  58                pop eax
000015E3  5A                pop edx
000015E4  8D6C242C          lea ebp,[esp+0x2c]
000015E8  55                push ebp
000015E9  57                push edi
000015EA  E8C1FBFFFF        call dword 0x11b0
000015EF  FF74243C          push dword [esp+0x3c]
000015F3  FF742438          push dword [esp+0x38]
000015F7  FF742440          push dword [esp+0x40]
000015FB  68CCF01000        push dword 0x10f0cc
00001600  E8DB0E0000        call dword 0x24e0
00001605  8D4310            lea eax,[ebx+0x10]
00001608  83C418            add esp,byte +0x18
0000160B  55                push ebp
0000160C  50                push eax
0000160D  E89EFBFFFF        call dword 0x11b0
00001612  FF74243C          push dword [esp+0x3c]
00001616  FF742438          push dword [esp+0x38]
0000161A  FF742440          push dword [esp+0x40]
0000161E  68CCF01000        push dword 0x10f0cc
00001623  E8B80E0000        call dword 0x24e0
00001628  8D4318            lea eax,[ebx+0x18]
0000162B  83C418            add esp,byte +0x18
0000162E  83C320            add ebx,byte +0x20
00001631  55                push ebp
00001632  50                push eax
00001633  E878FBFFFF        call dword 0x11b0
00001638  FF74243C          push dword [esp+0x3c]
0000163C  FF742438          push dword [esp+0x38]
00001640  FF742440          push dword [esp+0x40]
00001644  68CCF01000        push dword 0x10f0cc
00001649  E8920E0000        call dword 0x24e0
0000164E  83C418            add esp,byte +0x18
00001651  55                push ebp
00001652  53                push ebx
00001653  E858FBFFFF        call dword 0x11b0
00001658  FF74243C          push dword [esp+0x3c]
0000165C  FF742438          push dword [esp+0x38]
00001660  FF742440          push dword [esp+0x40]
00001664  68CCF01000        push dword 0x10f0cc
00001669  E8720E0000        call dword 0x24e0
0000166E  83C414            add esp,byte +0x14
00001671  68D6E21000        push dword 0x10e2d6
00001676  E8650E0000        call dword 0x24e0
0000167B  893424            mov [esp],esi
0000167E  E8E9F9FFFF        call dword 0x106c
00001683  83C40C            add esp,byte +0xc
00001686  68707A1000        push dword 0x107a70
0000168B  0FBF442428        movsx eax,word [esp+0x28]
00001690  C1E010            shl eax,byte 0x10
00001693  89C2              mov edx,eax
00001695  0FBF442426        movsx eax,word [esp+0x26]
0000169A  09D0              or eax,edx
0000169C  50                push eax
0000169D  68AFE11000        push dword 0x10e1af
000016A2  E8390E0000        call dword 0x24e0
000016A7  0FB705767A1000    movzx eax,word [dword 0x107a76]
000016AE  83C40C            add esp,byte +0xc
000016B1  50                push eax
000016B2  0FB605757A1000    movzx eax,byte [dword 0x107a75]
000016B9  89C2              mov edx,eax
000016BB  C0EA07            shr dl,byte 0x7
000016BE  0FB6D2            movzx edx,dl
000016C1  52                push edx
000016C2  89C2              mov edx,eax
000016C4  C0EA05            shr dl,byte 0x5
000016C7  83E203            and edx,byte +0x3
000016CA  52                push edx
000016CB  89C2              mov edx,eax
000016CD  C0EA04            shr dl,byte 0x4
000016D0  83E201            and edx,byte +0x1
000016D3  52                push edx
000016D4  89C2              mov edx,eax
000016D6  C0EA03            shr dl,byte 0x3
000016D9  83E201            and edx,byte +0x1
000016DC  52                push edx
000016DD  89C2              mov edx,eax
000016DF  83E003            and eax,byte +0x3
000016E2  C0EA02            shr dl,byte 0x2
000016E5  83E201            and edx,byte +0x1
000016E8  52                push edx
000016E9  50                push eax
000016EA  0FB605747A1000    movzx eax,byte [dword 0x107a74]
000016F1  50                push eax
000016F2  0FB705727A1000    movzx eax,word [dword 0x107a72]
000016F9  50                push eax
000016FA  0FB705707A1000    movzx eax,word [dword 0x107a70]
00001701  50                push eax
00001702  68ECF01000        push dword 0x10f0ec
00001707  E8D40D0000        call dword 0x24e0
0000170C  0FB705767A1000    movzx eax,word [dword 0x107a76]
00001713  83C42C            add esp,byte +0x2c
00001716  6827901000        push dword 0x109027
0000171B  C1E010            shl eax,byte 0x10
0000171E  89C2              mov edx,eax
00001720  0FB705707A1000    movzx eax,word [dword 0x107a70]
00001727  09D0              or eax,edx
00001729  50                push eax
0000172A  68BBE11000        push dword 0x10e1bb
0000172F  E8AC0D0000        call dword 0x24e0
00001734  59                pop ecx
00001735  5B                pop ebx
00001736  6A08              push byte +0x8
00001738  68C9E11000        push dword 0x10e1c9
0000173D  E89E0D0000        call dword 0x24e0
00001742  E82DF9FFFF        call dword 0x1074
00001747  5E                pop esi
00001748  5F                pop edi
00001749  89C3              mov ebx,eax
0000174B  2500020000        and eax,0x200
00001750  BEFFFFFFFF        mov esi,0xffffffff
00001755  50                push eax
00001756  68DFE11000        push dword 0x10e1df
0000175B  E8800D0000        call dword 0x24e0
00001760  C70424EBE11000    mov dword [esp],0x10e1eb
00001767  E8740D0000        call dword 0x24e0
0000176C  89D8              mov eax,ebx
0000176E  83C40C            add esp,byte +0xc
00001771  83E001            and eax,byte +0x1
00001774  50                push eax
00001775  68F6E11000        push dword 0x10e1f6
0000177A  68FCE11000        push dword 0x10e1fc
0000177F  E85C0D0000        call dword 0x24e0
00001784  89D8              mov eax,ebx
00001786  83C40C            add esp,byte +0xc
00001789  C1E802            shr eax,byte 0x2
0000178C  83E001            and eax,byte +0x1
0000178F  50                push eax
00001790  6805E21000        push dword 0x10e205
00001795  68FCE11000        push dword 0x10e1fc
0000179A  E8410D0000        call dword 0x24e0
0000179F  89D8              mov eax,ebx
000017A1  83C40C            add esp,byte +0xc
000017A4  C1E804            shr eax,byte 0x4
000017A7  83E001            and eax,byte +0x1
000017AA  50                push eax
000017AB  680CE21000        push dword 0x10e20c
000017B0  68FCE11000        push dword 0x10e1fc
000017B5  E8260D0000        call dword 0x24e0
000017BA  89D8              mov eax,ebx
000017BC  83C40C            add esp,byte +0xc
000017BF  C1E805            shr eax,byte 0x5
000017C2  83E001            and eax,byte +0x1
000017C5  50                push eax
000017C6  6813E21000        push dword 0x10e213
000017CB  68FCE11000        push dword 0x10e1fc
000017D0  E80B0D0000        call dword 0x24e0
000017D5  89D8              mov eax,ebx
000017D7  83C40C            add esp,byte +0xc
000017DA  C1E806            shr eax,byte 0x6
000017DD  83E001            and eax,byte +0x1
000017E0  50                push eax
000017E1  6818E21000        push dword 0x10e218
000017E6  68FCE11000        push dword 0x10e1fc
000017EB  E8F00C0000        call dword 0x24e0
000017F0  89D8              mov eax,ebx
000017F2  83C40C            add esp,byte +0xc
000017F5  C1E807            shr eax,byte 0x7
000017F8  83E001            and eax,byte +0x1
000017FB  50                push eax
000017FC  681DE21000        push dword 0x10e21d
00001801  68FCE11000        push dword 0x10e1fc
00001806  E8D50C0000        call dword 0x24e0
0000180B  89D8              mov eax,ebx
0000180D  83C40C            add esp,byte +0xc
00001810  C1E808            shr eax,byte 0x8
00001813  83E001            and eax,byte +0x1
00001816  50                push eax
00001817  6822E21000        push dword 0x10e222
0000181C  68FCE11000        push dword 0x10e1fc
00001821  E8BA0C0000        call dword 0x24e0
00001826  89D8              mov eax,ebx
00001828  83C40C            add esp,byte +0xc
0000182B  C1E809            shr eax,byte 0x9
0000182E  83E001            and eax,byte +0x1
00001831  50                push eax
00001832  682DE21000        push dword 0x10e22d
00001837  68FCE11000        push dword 0x10e1fc
0000183C  E89F0C0000        call dword 0x24e0
00001841  89D8              mov eax,ebx
00001843  83C40C            add esp,byte +0xc
00001846  C1E80A            shr eax,byte 0xa
00001849  83E001            and eax,byte +0x1
0000184C  50                push eax
0000184D  6837E21000        push dword 0x10e237
00001852  68FCE11000        push dword 0x10e1fc
00001857  E8840C0000        call dword 0x24e0
0000185C  89D8              mov eax,ebx
0000185E  83C40C            add esp,byte +0xc
00001861  C1E80B            shr eax,byte 0xb
00001864  83E003            and eax,byte +0x3
00001867  50                push eax
00001868  6840E21000        push dword 0x10e240
0000186D  68FCE11000        push dword 0x10e1fc
00001872  E8690C0000        call dword 0x24e0
00001877  89D8              mov eax,ebx
00001879  83C40C            add esp,byte +0xc
0000187C  C1E80D            shr eax,byte 0xd
0000187F  83E001            and eax,byte +0x1
00001882  50                push eax
00001883  6845E21000        push dword 0x10e245
00001888  68FCE11000        push dword 0x10e1fc
0000188D  E84E0C0000        call dword 0x24e0
00001892  89D8              mov eax,ebx
00001894  83C40C            add esp,byte +0xc
00001897  C1E80E            shr eax,byte 0xe
0000189A  83E001            and eax,byte +0x1
0000189D  50                push eax
0000189E  6851E21000        push dword 0x10e251
000018A3  68FCE11000        push dword 0x10e1fc
000018A8  E8330C0000        call dword 0x24e0
000018AD  89D8              mov eax,ebx
000018AF  83C40C            add esp,byte +0xc
000018B2  C1E80F            shr eax,byte 0xf
000018B5  83E001            and eax,byte +0x1
000018B8  50                push eax
000018B9  6858E21000        push dword 0x10e258
000018BE  68FCE11000        push dword 0x10e1fc
000018C3  E8180C0000        call dword 0x24e0
000018C8  89D8              mov eax,ebx
000018CA  83C40C            add esp,byte +0xc
000018CD  C1E810            shr eax,byte 0x10
000018D0  83E001            and eax,byte +0x1
000018D3  50                push eax
000018D4  686AE21000        push dword 0x10e26a
000018D9  68FCE11000        push dword 0x10e1fc
000018DE  E8FD0B0000        call dword 0x24e0
000018E3  89D8              mov eax,ebx
000018E5  83C40C            add esp,byte +0xc
000018E8  C1E811            shr eax,byte 0x11
000018EB  83E001            and eax,byte +0x1
000018EE  50                push eax
000018EF  687AE21000        push dword 0x10e27a
000018F4  68FCE11000        push dword 0x10e1fc
000018F9  E8E20B0000        call dword 0x24e0
000018FE  89D8              mov eax,ebx
00001900  83C40C            add esp,byte +0xc
00001903  C1E812            shr eax,byte 0x12
00001906  83E001            and eax,byte +0x1
00001909  50                push eax
0000190A  688CE21000        push dword 0x10e28c
0000190F  68FCE11000        push dword 0x10e1fc
00001914  E8C70B0000        call dword 0x24e0
00001919  89D8              mov eax,ebx
0000191B  83C40C            add esp,byte +0xc
0000191E  C1E813            shr eax,byte 0x13
00001921  83E001            and eax,byte +0x1
00001924  50                push eax
00001925  68A6E21000        push dword 0x10e2a6
0000192A  68FCE11000        push dword 0x10e1fc
0000192F  E8AC0B0000        call dword 0x24e0
00001934  C70424A9E21000    mov dword [esp],0x10e2a9
0000193B  E8A00B0000        call dword 0x24e0
00001940  A100311000        mov eax,[0x103100]
00001945  83C40C            add esp,byte +0xc
00001948  6820031000        push dword 0x100320
0000194D  50                push eax
0000194E  68ACE21000        push dword 0x10e2ac
00001953  E8880B0000        call dword 0x24e0
00001958  8B1D64201000      mov ebx,[dword 0x102064]
0000195E  83C410            add esp,byte +0x10
00001961  EB0D              jmp short 0x1970
00001963  90                nop
00001964  90                nop
00001965  90                nop
00001966  90                nop
00001967  90                nop
00001968  90                nop
00001969  90                nop
0000196A  90                nop
0000196B  90                nop
0000196C  90                nop
0000196D  90                nop
0000196E  90                nop
0000196F  90                nop
00001970  E89B120000        call dword 0x2c10
00001975  6639F0            cmp ax,si
00001978  7420              jz 0x199a
0000197A  6685C0            test ax,ax
0000197D  781B              js 0x199a
0000197F  89C2              mov edx,eax
00001981  83EC0C            sub esp,byte +0xc
00001984  83E27F            and edx,byte +0x7f
00001987  89442418          mov [esp+0x18],eax
0000198B  52                push edx
0000198C  E8CF0E0000        call dword 0x2860
00001991  83C410            add esp,byte +0x10
00001994  8B44240C          mov eax,[esp+0xc]
00001998  89C6              mov esi,eax
0000199A  A164201000        mov eax,[0x102064]
0000199F  39D8              cmp eax,ebx
000019A1  74CD              jz 0x1970
000019A3  8B1D64201000      mov ebx,[dword 0x102064]
000019A9  E862120000        call dword 0x2c10
000019AE  6639F0            cmp ax,si
000019B1  75C7              jnz 0x197a
000019B3  EBE5              jmp short 0x199a
000019B5  8D742600          lea esi,[esi+0x0]
000019B9  8DBC2700000000    lea edi,[edi+0x0]
000019C0  A164201000        mov eax,[0x102064]
000019C5  83C001            add eax,byte +0x1
000019C8  A364201000        mov [0x102064],eax
000019CD  A164201000        mov eax,[0x102064]
000019D2  83F8FF            cmp eax,byte -0x1
000019D5  7409              jz 0x19e0
000019D7  F3C3              rep ret
000019D9  8DB42600000000    lea esi,[esi+0x0]
000019E0  C705642010000000  mov dword [dword 0x102064],0x0
         -0000
000019EA  C3                ret
000019EB  90                nop
000019EC  8D742600          lea esi,[esi+0x0]
000019F0  C705642010000000  mov dword [dword 0x102064],0x0
         -0000
000019FA  C3                ret
000019FB  90                nop
000019FC  8D742600          lea esi,[esi+0x0]
00001A00  83EC0C            sub esp,byte +0xc
00001A03  C705642010000000  mov dword [dword 0x102064],0x0
         -0000
00001A0D  E8FEF7FFFF        call dword 0x1210
00001A12  E879090000        call dword 0x2390
00001A17  E8140D0000        call dword 0x2730
00001A1C  83EC0C            sub esp,byte +0xc
00001A1F  6884F11000        push dword 0x10f184
00001A24  E8B70A0000        call dword 0x24e0
00001A29  E872050000        call dword 0x1fa0
00001A2E  E8CD120000        call dword 0x2d00
00001A33  E898000000        call dword 0x1ad0
00001A38  C70424B6E21000    mov dword [esp],0x10e2b6
00001A3F  E89C0A0000        call dword 0x24e0
00001A44  83C41C            add esp,byte +0x1c
00001A47  C3                ret
00001A48  90                nop
00001A49  8DB42600000000    lea esi,[esi+0x0]
00001A50  83EC14            sub esp,byte +0x14
00001A53  6A00              push byte +0x0
00001A55  6A00              push byte +0x0
00001A57  E824F9FFFF        call dword 0x1380
00001A5C  8D742600          lea esi,[esi+0x0]
00001A60  83EC0C            sub esp,byte +0xc
00001A63  E898FFFFFF        call dword 0x1a00
00001A68  83EC08            sub esp,byte +0x8
00001A6B  6A20              push byte +0x20
00001A6D  68C6E21000        push dword 0x10e2c6
00001A72  E8690A0000        call dword 0x24e0
00001A77  83C40C            add esp,byte +0xc
00001A7A  6880031000        push dword 0x100380
00001A7F  6A00              push byte +0x0
00001A81  6A00              push byte +0x0
00001A83  E848010000        call dword 0x1bd0
00001A88  FB                sti
00001A89  C70424D8E21000    mov dword [esp],0x10e2d8
00001A90  E84B0A0000        call dword 0x24e0
00001A95  FB                sti
00001A96  31D2              xor edx,edx
00001A98  83C410            add esp,byte +0x10
00001A9B  90                nop
00001A9C  8D742600          lea esi,[esi+0x0]
00001AA0  A164201000        mov eax,[0x102064]
00001AA5  39D0              cmp eax,edx
00001AA7  74F7              jz 0x1aa0
00001AA9  A164201000        mov eax,[0x102064]
00001AAE  83EC08            sub esp,byte +0x8
00001AB1  50                push eax
00001AB2  68E1E21000        push dword 0x10e2e1
00001AB7  E8240A0000        call dword 0x24e0
00001ABC  8B1564201000      mov edx,[dword 0x102064]
00001AC2  83C410            add esp,byte +0x10
00001AC5  EBD9              jmp short 0x1aa0
00001AC7  6690              xchg ax,ax
00001AC9  6690              xchg ax,ax
00001ACB  6690              xchg ax,ax
00001ACD  6690              xchg ax,ax
00001ACF  90                nop
00001AD0  83EC10            sub esp,byte +0x10
00001AD3  C705C82810000000  mov dword [dword 0x1028c8],0x0
         -0000
00001ADD  C705802010000000  mov dword [dword 0x102080],0x0
         -0000
00001AE7  6800080000        push dword 0x800
00001AEC  6A00              push byte +0x0
00001AEE  68C0201000        push dword 0x1020c0
00001AF3  C705C02810000000  mov dword [dword 0x1028c0],0x0
         -0000
00001AFD  C705C42810000000  mov dword [dword 0x1028c4],0x0
         -0000
00001B07  E8E4050000        call dword 0x20f0
00001B0C  83C40C            add esp,byte +0xc
00001B0F  6800400000        push dword 0x4000
00001B14  6A00              push byte +0x0
00001B16  6828911000        push dword 0x109128
00001B1B  E8D0050000        call dword 0x20f0
00001B20  C705409110000100  mov dword [dword 0x109140],0x1
         -0000
00001B2A  A1C8281000        mov eax,[0x1028c8]
00001B2F  8D5001            lea edx,[eax+0x1]
00001B32  8915C8281000      mov [dword 0x1028c8],edx
00001B38  A33C911000        mov [0x10913c],eax
00001B3D  A1707A1000        mov eax,[0x107a70]
00001B42  A334911000        mov [0x109134],eax
00001B47  C705309110002891  mov dword [dword 0x109130],0x109128
         -1000
00001B51  C7052C9110002891  mov dword [dword 0x10912c],0x109128
         -1000
00001B5B  C705C02810002891  mov dword [dword 0x1028c0],0x109128
         -1000
00001B65  C705C42810002891  mov dword [dword 0x1028c4],0x109128
         -1000
00001B6F  C705802010000100  mov dword [dword 0x102080],0x1
         -0000
00001B79  83C41C            add esp,byte +0x1c
00001B7C  E990C60000        jmp dword 0xe211
00001B81  EB0D              jmp short 0x1b90
00001B83  90                nop
00001B84  90                nop
00001B85  90                nop
00001B86  90                nop
00001B87  90                nop
00001B88  90                nop
00001B89  90                nop
00001B8A  90                nop
00001B8B  90                nop
00001B8C  90                nop
00001B8D  90                nop
00001B8E  90                nop
00001B8F  90                nop
00001B90  8B542404          mov edx,[esp+0x4]
00001B94  3915C4201000      cmp [dword 0x1020c4],edx
00001B9A  B801000000        mov eax,0x1
00001B9F  741B              jz 0x1bbc
00001BA1  EB0D              jmp short 0x1bb0
00001BA3  90                nop
00001BA4  90                nop
00001BA5  90                nop
00001BA6  90                nop
00001BA7  90                nop
00001BA8  90                nop
00001BA9  90                nop
00001BAA  90                nop
00001BAB  90                nop
00001BAC  90                nop
00001BAD  90                nop
00001BAE  90                nop
00001BAF  90                nop
00001BB0  83C001            add eax,byte +0x1
00001BB3  391485C0201000    cmp [eax*4+0x1020c0],edx
00001BBA  75F4              jnz 0x1bb0
00001BBC  C70485C020100000  mov dword [eax*4+0x1020c0],0x0
         -000000
00001BC7  C3                ret
00001BC8  90                nop
00001BC9  8DB42600000000    lea esi,[esi+0x0]
00001BD0  55                push ebp
00001BD1  57                push edi
00001BD2  56                push esi
00001BD3  53                push ebx
00001BD4  83EC1C            sub esp,byte +0x1c
00001BD7  8B442430          mov eax,[esp+0x30]
00001BDB  8B6C2434          mov ebp,[esp+0x34]
00001BDF  8B742438          mov esi,[esp+0x38]
00001BE3  89442408          mov [esp+0x8],eax
00001BE7  FA                cli
00001BE8  31C0              xor eax,eax
00001BEA  EB12              jmp short 0x1bfe
00001BEC  8D742600          lea esi,[esi+0x0]
00001BF0  83C001            add eax,byte +0x1
00001BF3  3D00020000        cmp eax,0x200
00001BF8  0F8442010000      jz dword 0x1d40
00001BFE  89C3              mov ebx,eax
00001C00  C1E305            shl ebx,byte 0x5
00001C03  81C328911000      add ebx,0x109128
00001C09  8B7B18            mov edi,[ebx+0x18]
00001C0C  85FF              test edi,edi
00001C0E  75E0              jnz 0x1bf0
00001C10  85DB              test ebx,ebx
00001C12  0F8428010000      jz dword 0x1d40
00001C18  8B0D80201000      mov ecx,[dword 0x102080]
00001C1E  39C1              cmp ecx,eax
00001C20  0F8EEA000000      jng dword 0x1d10
00001C26  A1C4281000        mov eax,[0x1028c4]
00001C2B  83EC08            sub esp,byte +0x8
00001C2E  894308            mov [ebx+0x8],eax
00001C31  A1C4281000        mov eax,[0x1028c4]
00001C36  8B4004            mov eax,[eax+0x4]
00001C39  894304            mov [ebx+0x4],eax
00001C3C  A1C4281000        mov eax,[0x1028c4]
00001C41  8B4004            mov eax,[eax+0x4]
00001C44  895808            mov [eax+0x8],ebx
00001C47  A1C4281000        mov eax,[0x1028c4]
00001C4C  895804            mov [eax+0x4],ebx
00001C4F  A1C4281000        mov eax,[0x1028c4]
00001C54  A3C0281000        mov [0x1028c0],eax
00001C59  A180201000        mov eax,[0x102080]
00001C5E  50                push eax
00001C5F  6803E31000        push dword 0x10e303
00001C64  E877080000        call dword 0x24e0
00001C69  83C410            add esp,byte +0x10
00001C6C  31C9              xor ecx,ecx
00001C6E  EB0F              jmp short 0x1c7f
00001C70  83C101            add ecx,byte +0x1
00001C73  81F900020000      cmp ecx,0x200
00001C79  0F849E000000      jz dword 0x1d1d
00001C7F  8B048DC0201000    mov eax,[ecx*4+0x1020c0]
00001C86  85C0              test eax,eax
00001C88  75E6              jnz 0x1c70
00001C8A  8D5140            lea edx,[ecx+0x40]
00001C8D  894C240C          mov [esp+0xc],ecx
00001C91  83EC04            sub esp,byte +0x4
00001C94  C1E213            shl edx,byte 0x13
00001C97  52                push edx
00001C98  52                push edx
00001C99  89D7              mov edi,edx
00001C9B  681BE31000        push dword 0x10e31b
00001CA0  E83B080000        call dword 0x24e0
00001CA5  8B4C241C          mov ecx,[esp+0x1c]
00001CA9  89F8              mov eax,edi
00001CAB  83C410            add esp,byte +0x10
00001CAE  893C8DC0201000    mov [ecx*4+0x1020c0],edi
00001CB5  C7431801000000    mov dword [ebx+0x18],0x1
00001CBC  89430C            mov [ebx+0xc],eax
00001CBF  897310            mov [ebx+0x10],esi
00001CC2  A1C8281000        mov eax,[0x1028c8]
00001CC7  8B542408          mov edx,[esp+0x8]
00001CCB  8D4801            lea ecx,[eax+0x1]
00001CCE  890DC8281000      mov [dword 0x1028c8],ecx
00001CD4  894314            mov [ebx+0x14],eax
00001CD7  8B430C            mov eax,[ebx+0xc]
00001CDA  8928              mov [eax],ebp
00001CDC  8D68F8            lea ebp,[eax-0x8]
00001CDF  8950FC            mov [eax-0x4],edx
00001CE2  89E8              mov eax,ebp
00001CE4  29F0              sub eax,esi
00001CE6  50                push eax
00001CE7  56                push esi
00001CE8  57                push edi
00001CE9  68A4F11000        push dword 0x10f1a4
00001CEE  E8ED070000        call dword 0x24e0
00001CF3  892B              mov [ebx],ebp
00001CF5  895C2448          mov [esp+0x48],ebx
00001CF9  89742444          mov [esp+0x44],esi
00001CFD  896C2440          mov [esp+0x40],ebp
00001D01  83C42C            add esp,byte +0x2c
00001D04  5B                pop ebx
00001D05  5E                pop esi
00001D06  5F                pop edi
00001D07  5D                pop ebp
00001D08  E971C40000        jmp dword 0xe17e
00001D0D  8D7600            lea esi,[esi+0x0]
00001D10  83C001            add eax,byte +0x1
00001D13  A380201000        mov [0x102080],eax
00001D18  E909FFFFFF        jmp dword 0x1c26
00001D1D  83EC08            sub esp,byte +0x8
00001D20  6828E31000        push dword 0x10e328
00001D25  6A00              push byte +0x0
00001D27  E864070000        call dword 0x2490
00001D2C  83C410            add esp,byte +0x10
00001D2F  31C0              xor eax,eax
00001D31  EB82              jmp short 0x1cb5
00001D33  8DB600000000      lea esi,[esi+0x0]
00001D39  8DBC2700000000    lea edi,[edi+0x0]
00001D40  C7442434ECE21000  mov dword [esp+0x34],0x10e2ec
00001D48  C744243000000000  mov dword [esp+0x30],0x0
00001D50  83C41C            add esp,byte +0x1c
00001D53  5B                pop ebx
00001D54  5E                pop esi
00001D55  5F                pop edi
00001D56  5D                pop ebp
00001D57  E934070000        jmp dword 0x2490
00001D5C  8D742600          lea esi,[esi+0x0]
00001D60  A1C4281000        mov eax,[0x1028c4]
00001D65  C3                ret
00001D66  8D7600            lea esi,[esi+0x0]
00001D69  8DBC2700000000    lea edi,[edi+0x0]
00001D70  8B442404          mov eax,[esp+0x4]
00001D74  A3C4281000        mov [0x1028c4],eax
00001D79  C3                ret
00001D7A  8DB600000000      lea esi,[esi+0x0]
00001D80  A1C4281000        mov eax,[0x1028c4]
00001D85  8B4004            mov eax,[eax+0x4]
00001D88  C3                ret
00001D89  6690              xchg ax,ax
00001D8B  6690              xchg ax,ax
00001D8D  6690              xchg ax,ax
00001D8F  90                nop
00001D90  31C0              xor eax,eax
00001D92  C3                ret
00001D93  8DB600000000      lea esi,[esi+0x0]
00001D99  8DBC2700000000    lea edi,[edi+0x0]
00001DA0  53                push ebx
00001DA1  8B442408          mov eax,[esp+0x8]
00001DA5  BA21000000        mov edx,0x21
00001DAA  3C07              cmp al,0x7
00001DAC  89C1              mov ecx,eax
00001DAE  7605              jna 0x1db5
00001DB0  8D48F8            lea ecx,[eax-0x8]
00001DB3  B2A1              mov dl,0xa1
00001DB5  EC                in al,dx
00001DB6  BB01000000        mov ebx,0x1
00001DBB  D3E3              shl ebx,cl
00001DBD  09D8              or eax,ebx
00001DBF  EE                out dx,al
00001DC0  5B                pop ebx
00001DC1  C3                ret
00001DC2  8DB42600000000    lea esi,[esi+0x0]
00001DC9  8DBC2700000000    lea edi,[edi+0x0]
00001DD0  53                push ebx
00001DD1  8B442408          mov eax,[esp+0x8]
00001DD5  BA21000000        mov edx,0x21
00001DDA  3C07              cmp al,0x7
00001DDC  89C1              mov ecx,eax
00001DDE  7605              jna 0x1de5
00001DE0  8D48F8            lea ecx,[eax-0x8]
00001DE3  B2A1              mov dl,0xa1
00001DE5  EC                in al,dx
00001DE6  BBFEFFFFFF        mov ebx,0xfffffffe
00001DEB  D3C3              rol ebx,cl
00001DED  21D8              and eax,ebx
00001DEF  EE                out dx,al
00001DF0  5B                pop ebx
00001DF1  C3                ret
00001DF2  8DB42600000000    lea esi,[esi+0x0]
00001DF9  8DBC2700000000    lea edi,[edi+0x0]
00001E00  E421              in al,0x21
00001E02  89C1              mov ecx,eax
00001E04  E4A1              in al,0xa1
00001E06  89C2              mov edx,eax
00001E08  B811000000        mov eax,0x11
00001E0D  E620              out 0x20,al
00001E0F  31C0              xor eax,eax
00001E11  E680              out 0x80,al
00001E13  B811000000        mov eax,0x11
00001E18  E6A0              out 0xa0,al
00001E1A  31C0              xor eax,eax
00001E1C  E680              out 0x80,al
00001E1E  8B442404          mov eax,[esp+0x4]
00001E22  E621              out 0x21,al
00001E24  31C0              xor eax,eax
00001E26  E680              out 0x80,al
00001E28  8B442408          mov eax,[esp+0x8]
00001E2C  E6A1              out 0xa1,al
00001E2E  31C0              xor eax,eax
00001E30  E680              out 0x80,al
00001E32  B804000000        mov eax,0x4
00001E37  E621              out 0x21,al
00001E39  31C0              xor eax,eax
00001E3B  E680              out 0x80,al
00001E3D  B802000000        mov eax,0x2
00001E42  E6A1              out 0xa1,al
00001E44  31C0              xor eax,eax
00001E46  E680              out 0x80,al
00001E48  B801000000        mov eax,0x1
00001E4D  E621              out 0x21,al
00001E4F  31C0              xor eax,eax
00001E51  E680              out 0x80,al
00001E53  B801000000        mov eax,0x1
00001E58  E6A1              out 0xa1,al
00001E5A  31C0              xor eax,eax
00001E5C  E680              out 0x80,al
00001E5E  89C8              mov eax,ecx
00001E60  E621              out 0x21,al
00001E62  89D0              mov eax,edx
00001E64  E6A1              out 0xa1,al
00001E66  C3                ret
00001E67  89F6              mov esi,esi
00001E69  8DBC2700000000    lea edi,[edi+0x0]
00001E70  E9A9F1FFFF        jmp dword 0x101e
00001E75  8D742600          lea esi,[esi+0x0]
00001E79  8DBC2700000000    lea edi,[edi+0x0]
00001E80  B80A000000        mov eax,0xa
00001E85  E620              out 0x20,al
00001E87  E6A0              out 0xa0,al
00001E89  E4A0              in al,0xa0
00001E8B  89C1              mov ecx,eax
00001E8D  E420              in al,0x20
00001E8F  0FB6D0            movzx edx,al
00001E92  89C8              mov eax,ecx
00001E94  C1E008            shl eax,byte 0x8
00001E97  09D0              or eax,edx
00001E99  C3                ret
00001E9A  8DB600000000      lea esi,[esi+0x0]
00001EA0  B80B000000        mov eax,0xb
00001EA5  E620              out 0x20,al
00001EA7  E6A0              out 0xa0,al
00001EA9  E4A0              in al,0xa0
00001EAB  89C1              mov ecx,eax
00001EAD  E420              in al,0x20
00001EAF  0FB6D0            movzx edx,al
00001EB2  89C8              mov eax,ecx
00001EB4  C1E008            shl eax,byte 0x8
00001EB7  09D0              or eax,edx
00001EB9  C3                ret
00001EBA  8DB600000000      lea esi,[esi+0x0]
00001EC0  83EC18            sub esp,byte +0x18
00001EC3  6A02              push byte +0x2
00001EC5  FF1510291000      call dword [dword 0x102910]
00001ECB  83C41C            add esp,byte +0x1c
00001ECE  C3                ret
00001ECF  90                nop
00001ED0  83EC18            sub esp,byte +0x18
00001ED3  6A03              push byte +0x3
00001ED5  FF1518291000      call dword [dword 0x102918]
00001EDB  83C41C            add esp,byte +0x1c
00001EDE  C3                ret
00001EDF  90                nop
00001EE0  83EC18            sub esp,byte +0x18
00001EE3  6A04              push byte +0x4
00001EE5  FF1520291000      call dword [dword 0x102920]
00001EEB  83C41C            add esp,byte +0x1c
00001EEE  C3                ret
00001EEF  90                nop
00001EF0  83EC18            sub esp,byte +0x18
00001EF3  6A05              push byte +0x5
00001EF5  FF1528291000      call dword [dword 0x102928]
00001EFB  83C41C            add esp,byte +0x1c
00001EFE  C3                ret
00001EFF  90                nop
00001F00  83EC18            sub esp,byte +0x18
00001F03  6A06              push byte +0x6
00001F05  FF1530291000      call dword [dword 0x102930]
00001F0B  83C41C            add esp,byte +0x1c
00001F0E  C3                ret
00001F0F  90                nop
00001F10  83EC18            sub esp,byte +0x18
00001F13  6A07              push byte +0x7
00001F15  FF1538291000      call dword [dword 0x102938]
00001F1B  83C41C            add esp,byte +0x1c
00001F1E  C3                ret
00001F1F  90                nop
00001F20  83EC18            sub esp,byte +0x18
00001F23  6A08              push byte +0x8
00001F25  FF1540291000      call dword [dword 0x102940]
00001F2B  83C41C            add esp,byte +0x1c
00001F2E  C3                ret
00001F2F  90                nop
00001F30  83EC18            sub esp,byte +0x18
00001F33  6A09              push byte +0x9
00001F35  FF1548291000      call dword [dword 0x102948]
00001F3B  83C41C            add esp,byte +0x1c
00001F3E  C3                ret
00001F3F  90                nop
00001F40  83EC18            sub esp,byte +0x18
00001F43  6A0A              push byte +0xa
00001F45  FF1550291000      call dword [dword 0x102950]
00001F4B  83C41C            add esp,byte +0x1c
00001F4E  C3                ret
00001F4F  90                nop
00001F50  83EC18            sub esp,byte +0x18
00001F53  6A0B              push byte +0xb
00001F55  FF1558291000      call dword [dword 0x102958]
00001F5B  83C41C            add esp,byte +0x1c
00001F5E  C3                ret
00001F5F  90                nop
00001F60  83EC18            sub esp,byte +0x18
00001F63  6A0C              push byte +0xc
00001F65  FF1560291000      call dword [dword 0x102960]
00001F6B  83C41C            add esp,byte +0x1c
00001F6E  C3                ret
00001F6F  90                nop
00001F70  83EC18            sub esp,byte +0x18
00001F73  6A0D              push byte +0xd
00001F75  FF1568291000      call dword [dword 0x102968]
00001F7B  83C41C            add esp,byte +0x1c
00001F7E  C3                ret
00001F7F  90                nop
00001F80  83EC18            sub esp,byte +0x18
00001F83  6A0E              push byte +0xe
00001F85  FF1570291000      call dword [dword 0x102970]
00001F8B  83C41C            add esp,byte +0x1c
00001F8E  C3                ret
00001F8F  90                nop
00001F90  83EC18            sub esp,byte +0x18
00001F93  6A0F              push byte +0xf
00001F95  FF1578291000      call dword [dword 0x102978]
00001F9B  83C41C            add esp,byte +0x1c
00001F9E  C3                ret
00001F9F  90                nop
00001FA0  53                push ebx
00001FA1  83EC0C            sub esp,byte +0xc
00001FA4  FA                cli
00001FA5  6800080000        push dword 0x800
00001FAA  6A00              push byte +0x0
00001FAC  68707A1000        push dword 0x107a70
00001FB1  E83A010000        call dword 0x20f0
00001FB6  B800291000        mov eax,0x102900
00001FBB  83C410            add esp,byte +0x10
00001FBE  6690              xchg ax,ax
00001FC0  C700900D1000      mov dword [eax],0x100d90
00001FC6  C7400400000000    mov dword [eax+0x4],0x0
00001FCD  83C008            add eax,byte +0x8
00001FD0  3D00311000        cmp eax,0x103100
00001FD5  75E9              jnz 0x1fc0
00001FD7  8B1D40D21000      mov ebx,[dword 0x10d240]
00001FDD  85DB              test ebx,ebx
00001FDF  7E5F              jng 0x2040
00001FE1  31C0              xor eax,eax
00001FE3  8DB600000000      lea esi,[esi+0x0]
00001FE9  8DBC2700000000    lea edi,[edi+0x0]
00001FF0  89C2              mov edx,eax
00001FF2  800CC5757A10008F  or byte [eax*8+0x107a75],0x8f
00001FFA  C604C5727A100008  mov byte [eax*8+0x107a72],0x8
00002002  83E203            and edx,byte +0x3
00002005  C604C5737A100000  mov byte [eax*8+0x107a73],0x0
0000200D  8B149580D21000    mov edx,[edx*4+0x10d280]
00002014  8814C5707A1000    mov [eax*8+0x107a70],dl
0000201B  0FB6CE            movzx ecx,dh
0000201E  C1EA10            shr edx,byte 0x10
00002021  8814C5767A1000    mov [eax*8+0x107a76],dl
00002028  C1EA08            shr edx,byte 0x8
0000202B  880CC5717A1000    mov [eax*8+0x107a71],cl
00002032  8814C5777A1000    mov [eax*8+0x107a77],dl
00002039  83C001            add eax,byte +0x1
0000203C  39D8              cmp eax,ebx
0000203E  75B0              jnz 0x1ff0
00002040  83C408            add esp,byte +0x8
00002043  5B                pop ebx
00002044  E9BD7F0000        jmp dword 0xa006
00002049  8DB42600000000    lea esi,[esi+0x0]
00002050  0FB6442404        movzx eax,byte [esp+0x4]
00002055  8B542408          mov edx,[esp+0x8]
00002059  C704C50429100000  mov dword [eax*8+0x102904],0x0
         -000000
00002064  8914C500291000    mov [eax*8+0x102900],edx
0000206B  C3                ret
0000206C  8D742600          lea esi,[esi+0x0]
00002070  8B442404          mov eax,[esp+0x4]
00002074  C704C50029100090  mov dword [eax*8+0x102900],0x100d90
         -0D1000
0000207F  C704C50429100000  mov dword [eax*8+0x102904],0x0
         -000000
0000208A  C3                ret
0000208B  6690              xchg ax,ax
0000208D  6690              xchg ax,ax
0000208F  90                nop
00002090  8B542404          mov edx,[esp+0x4]
00002094  31C0              xor eax,eax
00002096  803A00            cmp byte [edx],0x0
00002099  7410              jz 0x20ab
0000209B  90                nop
0000209C  8D742600          lea esi,[esi+0x0]
000020A0  83C001            add eax,byte +0x1
000020A3  803C0200          cmp byte [edx+eax],0x0
000020A7  75F7              jnz 0x20a0
000020A9  F3C3              rep ret
000020AB  F3C3              rep ret
000020AD  8D7600            lea esi,[esi+0x0]
000020B0  53                push ebx
000020B1  8B4C2410          mov ecx,[esp+0x10]
000020B5  8B442408          mov eax,[esp+0x8]
000020B9  8B54240C          mov edx,[esp+0xc]
000020BD  85C9              test ecx,ecx
000020BF  8D1C08            lea ebx,[eax+ecx]
000020C2  741C              jz 0x20e0
000020C4  8DB600000000      lea esi,[esi+0x0]
000020CA  8DBF00000000      lea edi,[edi+0x0]
000020D0  0FB60A            movzx ecx,byte [edx]
000020D3  83C001            add eax,byte +0x1
000020D6  83C201            add edx,byte +0x1
000020D9  8848FF            mov [eax-0x1],cl
000020DC  39D8              cmp eax,ebx
000020DE  75F0              jnz 0x20d0
000020E0  31C0              xor eax,eax
000020E2  5B                pop ebx
000020E3  C3                ret
000020E4  8DB600000000      lea esi,[esi+0x0]
000020EA  8DBF00000000      lea edi,[edi+0x0]
000020F0  53                push ebx
000020F1  8B5C2410          mov ebx,[esp+0x10]
000020F5  8B442408          mov eax,[esp+0x8]
000020F9  0FB64C240C        movzx ecx,byte [esp+0xc]
000020FE  85DB              test ebx,ebx
00002100  8D1418            lea edx,[eax+ebx]
00002103  7414              jz 0x2119
00002105  8D742600          lea esi,[esi+0x0]
00002109  8DBC2700000000    lea edi,[edi+0x0]
00002110  8808              mov [eax],cl
00002112  83C001            add eax,byte +0x1
00002115  39D0              cmp eax,edx
00002117  75F7              jnz 0x2110
00002119  31C0              xor eax,eax
0000211B  5B                pop ebx
0000211C  C3                ret
0000211D  8D7600            lea esi,[esi+0x0]
00002120  57                push edi
00002121  56                push esi
00002122  53                push ebx
00002123  8B7C2410          mov edi,[esp+0x10]
00002127  85FF              test edi,edi
00002129  7535              jnz 0x2160
0000212B  C6052036100030    mov byte [dword 0x103620],0x30
00002132  BB01000000        mov ebx,0x1
00002137  89F6              mov esi,esi
00002139  8DBC2700000000    lea edi,[edi+0x0]
00002140  83EB01            sub ebx,byte +0x1
00002143  0FB68320361000    movzx eax,byte [ebx+0x103620]
0000214A  83EC0C            sub esp,byte +0xc
0000214D  50                push eax
0000214E  E80D070000        call dword 0x2860
00002153  83C410            add esp,byte +0x10
00002156  85DB              test ebx,ebx
00002158  75E6              jnz 0x2140
0000215A  5B                pop ebx
0000215B  31C0              xor eax,eax
0000215D  5E                pop esi
0000215E  5F                pop edi
0000215F  C3                ret
00002160  89F8              mov eax,edi
00002162  31DB              xor ebx,ebx
00002164  BE67666666        mov esi,0x66666667
00002169  C1F81F            sar eax,byte 0x1f
0000216C  89C1              mov ecx,eax
0000216E  31F9              xor ecx,edi
00002170  29C1              sub ecx,eax
00002172  8DB42600000000    lea esi,[esi+0x0]
00002179  8DBC2700000000    lea edi,[edi+0x0]
00002180  89C8              mov eax,ecx
00002182  83C301            add ebx,byte +0x1
00002185  F7EE              imul esi
00002187  89C8              mov eax,ecx
00002189  C1F81F            sar eax,byte 0x1f
0000218C  C1FA02            sar edx,byte 0x2
0000218F  29C2              sub edx,eax
00002191  8D0492            lea eax,[edx+edx*4]
00002194  01C0              add eax,eax
00002196  29C1              sub ecx,eax
00002198  83C130            add ecx,byte +0x30
0000219B  85D2              test edx,edx
0000219D  888B1F361000      mov [ebx+0x10361f],cl
000021A3  89D1              mov ecx,edx
000021A5  75D9              jnz 0x2180
000021A7  85FF              test edi,edi
000021A9  7995              jns 0x2140
000021AB  89D8              mov eax,ebx
000021AD  83C301            add ebx,byte +0x1
000021B0  C680203610002D    mov byte [eax+0x103620],0x2d
000021B7  EB87              jmp short 0x2140
000021B9  8DB42600000000    lea esi,[esi+0x0]
000021C0  56                push esi
000021C1  53                push ebx
000021C2  83EC04            sub esp,byte +0x4
000021C5  8B4C2410          mov ecx,[esp+0x10]
000021C9  85C9              test ecx,ecx
000021CB  7543              jnz 0x2210
000021CD  C6050036100030    mov byte [dword 0x103600],0x30
000021D4  BB01000000        mov ebx,0x1
000021D9  8DB42600000000    lea esi,[esi+0x0]
000021E0  83EB01            sub ebx,byte +0x1
000021E3  0FB68300361000    movzx eax,byte [ebx+0x103600]
000021EA  83EC0C            sub esp,byte +0xc
000021ED  50                push eax
000021EE  E86D060000        call dword 0x2860
000021F3  83C410            add esp,byte +0x10
000021F6  85DB              test ebx,ebx
000021F8  75E6              jnz 0x21e0
000021FA  83C404            add esp,byte +0x4
000021FD  31C0              xor eax,eax
000021FF  5B                pop ebx
00002200  5E                pop esi
00002201  C3                ret
00002202  8DB42600000000    lea esi,[esi+0x0]
00002209  8DBC2700000000    lea edi,[edi+0x0]
00002210  89C8              mov eax,ecx
00002212  31DB              xor ebx,ebx
00002214  BE67666666        mov esi,0x66666667
00002219  C1F81F            sar eax,byte 0x1f
0000221C  31C1              xor ecx,eax
0000221E  29C1              sub ecx,eax
00002220  89C8              mov eax,ecx
00002222  83C301            add ebx,byte +0x1
00002225  F7EE              imul esi
00002227  89C8              mov eax,ecx
00002229  C1F81F            sar eax,byte 0x1f
0000222C  C1FA02            sar edx,byte 0x2
0000222F  29C2              sub edx,eax
00002231  8D0492            lea eax,[edx+edx*4]
00002234  01C0              add eax,eax
00002236  29C1              sub ecx,eax
00002238  83C130            add ecx,byte +0x30
0000223B  85D2              test edx,edx
0000223D  888BFF351000      mov [ebx+0x1035ff],cl
00002243  89D1              mov ecx,edx
00002245  75D9              jnz 0x2220
00002247  EB97              jmp short 0x21e0
00002249  8DB42600000000    lea esi,[esi+0x0]
00002250  53                push ebx
00002251  83EC08            sub esp,byte +0x8
00002254  8B442410          mov eax,[esp+0x10]
00002258  85C0              test eax,eax
0000225A  7564              jnz 0x22c0
0000225C  83EC0C            sub esp,byte +0xc
0000225F  C605E035100030    mov byte [dword 0x1035e0],0x30
00002266  BB01000000        mov ebx,0x1
0000226B  6A30              push byte +0x30
0000226D  E8EE050000        call dword 0x2860
00002272  C7042478000000    mov dword [esp],0x78
00002279  E8E2050000        call dword 0x2860
0000227E  83C410            add esp,byte +0x10
00002281  EB0D              jmp short 0x2290
00002283  90                nop
00002284  90                nop
00002285  90                nop
00002286  90                nop
00002287  90                nop
00002288  90                nop
00002289  90                nop
0000228A  90                nop
0000228B  90                nop
0000228C  90                nop
0000228D  90                nop
0000228E  90                nop
0000228F  90                nop
00002290  83EB01            sub ebx,byte +0x1
00002293  0FB683E0351000    movzx eax,byte [ebx+0x1035e0]
0000229A  83EC0C            sub esp,byte +0xc
0000229D  50                push eax
0000229E  E8BD050000        call dword 0x2860
000022A3  83C410            add esp,byte +0x10
000022A6  85DB              test ebx,ebx
000022A8  75E6              jnz 0x2290
000022AA  83C408            add esp,byte +0x8
000022AD  B802000000        mov eax,0x2
000022B2  5B                pop ebx
000022B3  C3                ret
000022B4  8DB600000000      lea esi,[esi+0x0]
000022BA  8DBF00000000      lea edi,[edi+0x0]
000022C0  99                cdq
000022C1  31DB              xor ebx,ebx
000022C3  31D0              xor eax,edx
000022C5  29D0              sub eax,edx
000022C7  89F6              mov esi,esi
000022C9  8DBC2700000000    lea edi,[edi+0x0]
000022D0  89C2              mov edx,eax
000022D2  C1F804            sar eax,byte 0x4
000022D5  83C301            add ebx,byte +0x1
000022D8  83E20F            and edx,byte +0xf
000022DB  85C0              test eax,eax
000022DD  0FB69200E01000    movzx edx,byte [edx+0x10e000]
000022E4  8893DF351000      mov [ebx+0x1035df],dl
000022EA  75E4              jnz 0x22d0
000022EC  83EC0C            sub esp,byte +0xc
000022EF  6A30              push byte +0x30
000022F1  E86A050000        call dword 0x2860
000022F6  C7042478000000    mov dword [esp],0x78
000022FD  E85E050000        call dword 0x2860
00002302  83C410            add esp,byte +0x10
00002305  EB89              jmp short 0x2290
00002307  89F6              mov esi,esi
00002309  8DBC2700000000    lea edi,[edi+0x0]
00002310  0FB6442404        movzx eax,byte [esp+0x4]
00002315  0FB68040311000    movzx eax,byte [eax+0x103140]
0000231C  C3                ret
0000231D  8D7600            lea esi,[esi+0x0]
00002320  0FB6442404        movzx eax,byte [esp+0x4]
00002325  0FB68040321000    movzx eax,byte [eax+0x103240]
0000232C  C3                ret
0000232D  8D7600            lea esi,[esi+0x0]
00002330  0FB6442404        movzx eax,byte [esp+0x4]
00002335  0FB6542404        movzx edx,byte [esp+0x4]
0000233A  389040311000      cmp [eax+0x103140],dl
00002340  0F94C0            setz al
00002343  0FB6C0            movzx eax,al
00002346  C3                ret
00002347  89F6              mov esi,esi
00002349  8DBC2700000000    lea edi,[edi+0x0]
00002350  0FB6442404        movzx eax,byte [esp+0x4]
00002355  0FB6542404        movzx edx,byte [esp+0x4]
0000235A  389040321000      cmp [eax+0x103240],dl
00002360  0F94C0            setz al
00002363  0FB6C0            movzx eax,al
00002366  C3                ret
00002367  89F6              mov esi,esi
00002369  8DBC2700000000    lea edi,[edi+0x0]
00002370  8B542404          mov edx,[esp+0x4]
00002374  83FA7F            cmp edx,byte +0x7f
00002377  0F95C0            setnz al
0000237A  83FA1F            cmp edx,byte +0x1f
0000237D  0F9FC2            setg dl
00002380  0FB6D2            movzx edx,dl
00002383  21D0              and eax,edx
00002385  C3                ret
00002386  8D7600            lea esi,[esi+0x0]
00002389  8DBC2700000000    lea edi,[edi+0x0]
00002390  C705003110000000  mov dword [dword 0x103100],0x0
         -0000
0000239A  31C0              xor eax,eax
0000239C  8D742600          lea esi,[esi+0x0]
000023A0  888040321000      mov [eax+0x103240],al
000023A6  888040311000      mov [eax+0x103140],al
000023AC  83C001            add eax,byte +0x1
000023AF  3DFF000000        cmp eax,0xff
000023B4  75EA              jnz 0x23a0
000023B6  B061              mov al,0x61
000023B8  90                nop
000023B9  8DB42600000000    lea esi,[esi+0x0]
000023C0  8D50E0            lea edx,[eax-0x20]
000023C3  83C001            add eax,byte +0x1
000023C6  88903F311000      mov [eax+0x10313f],dl
000023CC  83F87B            cmp eax,byte +0x7b
000023CF  75EF              jnz 0x23c0
000023D1  C605A03110007E    mov byte [dword 0x1031a0],0x7e
000023D8  C6057131100021    mov byte [dword 0x103171],0x21
000023DF  30C0              xor al,al
000023E1  C6057231100040    mov byte [dword 0x103172],0x40
000023E8  C6057331100023    mov byte [dword 0x103173],0x23
000023EF  C6057431100024    mov byte [dword 0x103174],0x24
000023F6  C6057531100025    mov byte [dword 0x103175],0x25
000023FD  C605763110005E    mov byte [dword 0x103176],0x5e
00002404  C6057731100026    mov byte [dword 0x103177],0x26
0000240B  C605783110002A    mov byte [dword 0x103178],0x2a
00002412  C6057931100028    mov byte [dword 0x103179],0x28
00002419  C6057031100029    mov byte [dword 0x103170],0x29
00002420  C6056D3110005F    mov byte [dword 0x10316d],0x5f
00002427  C6057D3110002B    mov byte [dword 0x10317d],0x2b
0000242E  C6059B3110007B    mov byte [dword 0x10319b],0x7b
00002435  C6059D3110007D    mov byte [dword 0x10319d],0x7d
0000243C  C6057B3110003A    mov byte [dword 0x10317b],0x3a
00002443  C6056731100022    mov byte [dword 0x103167],0x22
0000244A  C6056C3110003C    mov byte [dword 0x10316c],0x3c
00002451  C6056E3110003E    mov byte [dword 0x10316e],0x3e
00002458  C6056F3110003F    mov byte [dword 0x10316f],0x3f
0000245F  C6059C3110007C    mov byte [dword 0x10319c],0x7c
00002466  8D7600            lea esi,[esi+0x0]
00002469  8DBC2700000000    lea edi,[edi+0x0]
00002470  0FB69040311000    movzx edx,byte [eax+0x103140]
00002477  888240321000      mov [edx+0x103240],al
0000247D  83C001            add eax,byte +0x1
00002480  3DFF000000        cmp eax,0xff
00002485  75E9              jnz 0x2470
00002487  F3C3              rep ret
00002489  8DB42600000000    lea esi,[esi+0x0]
00002490  53                push ebx
00002491  83EC08            sub esp,byte +0x8
00002494  E8F7020000        call dword 0x2790
00002499  83EC0C            sub esp,byte +0xc
0000249C  68D4F11000        push dword 0x10f1d4
000024A1  E83A000000        call dword 0x24e0
000024A6  83C40C            add esp,byte +0xc
000024A9  89C3              mov ebx,eax
000024AB  FF742418          push dword [esp+0x18]
000024AF  FF742418          push dword [esp+0x18]
000024B3  6842E31000        push dword 0x10e342
000024B8  E823000000        call dword 0x24e0
000024BD  C70424D4F11000    mov dword [esp],0x10f1d4
000024C4  01C3              add ebx,eax
000024C6  E815000000        call dword 0x24e0
000024CB  83C418            add esp,byte +0x18
000024CE  01D8              add eax,ebx
000024D0  5B                pop ebx
000024D1  C3                ret
000024D2  6690              xchg ax,ax
000024D4  6690              xchg ax,ax
000024D6  6690              xchg ax,ax
000024D8  6690              xchg ax,ax
000024DA  6690              xchg ax,ax
000024DC  6690              xchg ax,ax
000024DE  6690              xchg ax,ax
000024E0  55                push ebp
000024E1  57                push edi
000024E2  56                push esi
000024E3  53                push ebx
000024E4  83EC38            sub esp,byte +0x38
000024E7  8B7C244C          mov edi,[esp+0x4c]
000024EB  57                push edi
000024EC  E89FFBFFFF        call dword 0x2090
000024F1  8D742454          lea esi,[esp+0x54]
000024F5  8944241C          mov [esp+0x1c],eax
000024F9  83C410            add esp,byte +0x10
000024FC  85C0              test eax,eax
000024FE  0F8E03020000      jng dword 0x2707
00002504  83E801            sub eax,byte +0x1
00002507  31D2              xor edx,edx
00002509  31ED              xor ebp,ebp
0000250B  89442410          mov [esp+0x10],eax
0000250F  90                nop
00002510  0FB60C17          movzx ecx,byte [edi+edx]
00002514  3B542410          cmp edx,[esp+0x10]
00002518  8B5C240C          mov ebx,[esp+0xc]
0000251C  89C8              mov eax,ecx
0000251E  7408              jz 0x2528
00002520  0FB6441701        movzx eax,byte [edi+edx+0x1]
00002525  8D5A01            lea ebx,[edx+0x1]
00002528  83F925            cmp ecx,byte +0x25
0000252B  0F85AF010000      jnz dword 0x26e0
00002531  83E825            sub eax,byte +0x25
00002534  3C53              cmp al,0x53
00002536  0F87C4010000      ja dword 0x2700
0000253C  0FB6C0            movzx eax,al
0000253F  FF248514E01000    jmp dword [eax*4+0x10e014]
00002546  8D7600            lea esi,[esi+0x0]
00002549  8DBC2700000000    lea edi,[edi+0x0]
00002550  89F0              mov eax,esi
00002552  83EC0C            sub esp,byte +0xc
00002555  83C604            add esi,byte +0x4
00002558  FF30              push dword [eax]
0000255A  E8F1FCFFFF        call dword 0x2250
0000255F  8D5301            lea edx,[ebx+0x1]
00002562  01C5              add ebp,eax
00002564  83C410            add esp,byte +0x10
00002567  89F6              mov esi,esi
00002569  8DBC2700000000    lea edi,[edi+0x0]
00002570  3954240C          cmp [esp+0xc],edx
00002574  7F9A              jg 0x2510
00002576  83C42C            add esp,byte +0x2c
00002579  89E8              mov eax,ebp
0000257B  5B                pop ebx
0000257C  5E                pop esi
0000257D  5F                pop edi
0000257E  5D                pop ebp
0000257F  C3                ret
00002580  83EC0C            sub esp,byte +0xc
00002583  83C509            add ebp,byte +0x9
00002586  6A75              push byte +0x75
00002588  E8D3020000        call dword 0x2860
0000258D  C704246E000000    mov dword [esp],0x6e
00002594  E8C7020000        call dword 0x2860
00002599  C7042473000000    mov dword [esp],0x73
000025A0  E8BB020000        call dword 0x2860
000025A5  C7042475000000    mov dword [esp],0x75
000025AC  E8AF020000        call dword 0x2860
000025B1  C7042470000000    mov dword [esp],0x70
000025B8  E8A3020000        call dword 0x2860
000025BD  C7042470000000    mov dword [esp],0x70
000025C4  E897020000        call dword 0x2860
000025C9  C7042474000000    mov dword [esp],0x74
000025D0  E88B020000        call dword 0x2860
000025D5  C7042465000000    mov dword [esp],0x65
000025DC  E87F020000        call dword 0x2860
000025E1  C7042464000000    mov dword [esp],0x64
000025E8  E873020000        call dword 0x2860
000025ED  83C410            add esp,byte +0x10
000025F0  89DA              mov edx,ebx
000025F2  E979FFFFFF        jmp dword 0x2570
000025F7  89F6              mov esi,esi
000025F9  8DBC2700000000    lea edi,[edi+0x0]
00002600  89F0              mov eax,esi
00002602  83EC0C            sub esp,byte +0xc
00002605  83C604            add esi,byte +0x4
00002608  FF30              push dword [eax]
0000260A  E811FBFFFF        call dword 0x2120
0000260F  83C410            add esp,byte +0x10
00002612  01C5              add ebp,eax
00002614  8D5301            lea edx,[ebx+0x1]
00002617  E954FFFFFF        jmp dword 0x2570
0000261C  8D742600          lea esi,[esi+0x0]
00002620  83EC0C            sub esp,byte +0xc
00002623  83C501            add ebp,byte +0x1
00002626  6A25              push byte +0x25
00002628  E833020000        call dword 0x2860
0000262D  83C410            add esp,byte +0x10
00002630  8D5301            lea edx,[ebx+0x1]
00002633  E938FFFFFF        jmp dword 0x2570
00002638  90                nop
00002639  8DB42600000000    lea esi,[esi+0x0]
00002640  89F0              mov eax,esi
00002642  83EC0C            sub esp,byte +0xc
00002645  83C604            add esi,byte +0x4
00002648  FF30              push dword [eax]
0000264A  E871FBFFFF        call dword 0x21c0
0000264F  83C410            add esp,byte +0x10
00002652  01C5              add ebp,eax
00002654  8D5301            lea edx,[ebx+0x1]
00002657  E914FFFFFF        jmp dword 0x2570
0000265C  8D742600          lea esi,[esi+0x0]
00002660  83EC0C            sub esp,byte +0xc
00002663  83C501            add ebp,byte +0x1
00002666  6A25              push byte +0x25
00002668  E8F3010000        call dword 0x2860
0000266D  83C410            add esp,byte +0x10
00002670  8D5301            lea edx,[ebx+0x1]
00002673  E9F8FEFFFF        jmp dword 0x2570
00002678  90                nop
00002679  8DB42600000000    lea esi,[esi+0x0]
00002680  8D4604            lea eax,[esi+0x4]
00002683  8B36              mov esi,[esi]
00002685  83EC0C            sub esp,byte +0xc
00002688  89442420          mov [esp+0x20],eax
0000268C  56                push esi
0000268D  E8FEF9FFFF        call dword 0x2090
00002692  89442428          mov [esp+0x28],eax
00002696  83C410            add esp,byte +0x10
00002699  85C0              test eax,eax
0000269B  7E31              jng 0x26ce
0000269D  01F0              add eax,esi
0000269F  895C241C          mov [esp+0x1c],ebx
000026A3  89F3              mov ebx,esi
000026A5  89C6              mov esi,eax
000026A7  89F6              mov esi,esi
000026A9  8DBC2700000000    lea edi,[edi+0x0]
000026B0  0FB613            movzx edx,byte [ebx]
000026B3  83EC0C            sub esp,byte +0xc
000026B6  83C301            add ebx,byte +0x1
000026B9  52                push edx
000026BA  E8A1010000        call dword 0x2860
000026BF  83C410            add esp,byte +0x10
000026C2  39F3              cmp ebx,esi
000026C4  75EA              jnz 0x26b0
000026C6  036C2418          add ebp,[esp+0x18]
000026CA  8B5C241C          mov ebx,[esp+0x1c]
000026CE  8B742414          mov esi,[esp+0x14]
000026D2  8D5301            lea edx,[ebx+0x1]
000026D5  E996FEFFFF        jmp dword 0x2570
000026DA  8DB600000000      lea esi,[esi+0x0]
000026E0  83EC0C            sub esp,byte +0xc
000026E3  83C501            add ebp,byte +0x1
000026E6  51                push ecx
000026E7  E874010000        call dword 0x2860
000026EC  83C410            add esp,byte +0x10
000026EF  89DA              mov edx,ebx
000026F1  E97AFEFFFF        jmp dword 0x2570
000026F6  8D7600            lea esi,[esi+0x0]
000026F9  8DBC2700000000    lea edi,[edi+0x0]
00002700  89DA              mov edx,ebx
00002702  E969FEFFFF        jmp dword 0x2570
00002707  31ED              xor ebp,ebp
00002709  E968FEFFFF        jmp dword 0x2576
0000270E  6690              xchg ax,ax
00002710  0FB6442408        movzx eax,byte [esp+0x8]
00002715  C1E004            shl eax,byte 0x4
00002718  0A442404          or al,[esp+0x4]
0000271C  C3                ret
0000271D  8D7600            lea esi,[esi+0x0]
00002720  0FB6442408        movzx eax,byte [esp+0x8]
00002725  0FB6542404        movzx edx,byte [esp+0x4]
0000272A  C1E008            shl eax,byte 0x8
0000272D  09D0              or eax,edx
0000272F  C3                ret
00002730  C7054C3310000000  mov dword [dword 0x10334c],0x0
         -0000
0000273A  C705443310000000  mov dword [dword 0x103344],0x0
         -0000
00002744  B800800B00        mov eax,0xb8000
00002749  C6054033100007    mov byte [dword 0x103340],0x7
00002750  C705483310000080  mov dword [dword 0x103348],0xb8000
         -0B00
0000275A  8DB600000000      lea esi,[esi+0x0]
00002760  8D90A0000000      lea edx,[eax+0xa0]
00002766  8D7600            lea esi,[esi+0x0]
00002769  8DBC2700000000    lea edi,[edi+0x0]
00002770  B920070000        mov ecx,0x720
00002775  83C002            add eax,byte +0x2
00002778  668948FE          mov [eax-0x2],cx
0000277C  39D0              cmp eax,edx
0000277E  75F0              jnz 0x2770
00002780  3DA08F0B00        cmp eax,0xb8fa0
00002785  75D9              jnz 0x2760
00002787  F3C3              rep ret
00002789  8DB42600000000    lea esi,[esi+0x0]
00002790  83EC10            sub esp,byte +0x10
00002793  68A00F0000        push dword 0xfa0
00002798  6A00              push byte +0x0
0000279A  FF3548331000      push dword [dword 0x103348]
000027A0  E84BF9FFFF        call dword 0x20f0
000027A5  C705443310000000  mov dword [dword 0x103344],0x0
         -0000
000027AF  C7054C3310000000  mov dword [dword 0x10334c],0x0
         -0000
000027B9  83C41C            add esp,byte +0x1c
000027BC  C3                ret
000027BD  8D7600            lea esi,[esi+0x0]
000027C0  8B442404          mov eax,[esp+0x4]
000027C4  A240331000        mov [0x103340],al
000027C9  C3                ret
000027CA  8DB600000000      lea esi,[esi+0x0]
000027D0  8B442410          mov eax,[esp+0x10]
000027D4  0FB6542408        movzx edx,byte [esp+0x8]
000027D9  0FB64C2404        movzx ecx,byte [esp+0x4]
000027DE  8D0480            lea eax,[eax+eax*4]
000027E1  C1E208            shl edx,byte 0x8
000027E4  C1E004            shl eax,byte 0x4
000027E7  0344240C          add eax,[esp+0xc]
000027EB  09CA              or edx,ecx
000027ED  8B0D48331000      mov ecx,[dword 0x103348]
000027F3  66891441          mov [ecx+eax*2],dx
000027F7  C3                ret
000027F8  90                nop
000027F9  8DB42600000000    lea esi,[esi+0x0]
00002800  56                push esi
00002801  53                push ebx
00002802  83EC04            sub esp,byte +0x4
00002805  E86AE8FFFF        call dword 0x1074
0000280A  89C6              mov esi,eax
0000280C  FA                cli
0000280D  31D2              xor edx,edx
0000280F  90                nop
00002810  A148331000        mov eax,[0x103348]
00002815  8D9AA0000000      lea ebx,[edx+0xa0]
0000281B  83EC04            sub esp,byte +0x4
0000281E  68A0000000        push dword 0xa0
00002823  8D0C18            lea ecx,[eax+ebx]
00002826  01C2              add edx,eax
00002828  51                push ecx
00002829  52                push edx
0000282A  E881F8FFFF        call dword 0x20b0
0000282F  83C410            add esp,byte +0x10
00002832  81FB000F0000      cmp ebx,0xf00
00002838  89DA              mov edx,ebx
0000283A  75D4              jnz 0x2810
0000283C  56                push esi
0000283D  9D                popfd
0000283E  A148331000        mov eax,[0x103348]
00002843  83EC04            sub esp,byte +0x4
00002846  68A0000000        push dword 0xa0
0000284B  6A00              push byte +0x0
0000284D  05000F0000        add eax,0xf00
00002852  50                push eax
00002853  E898F8FFFF        call dword 0x20f0
00002858  83C414            add esp,byte +0x14
0000285B  5B                pop ebx
0000285C  5E                pop esi
0000285D  C3                ret
0000285E  6690              xchg ax,ax
00002860  57                push edi
00002861  56                push esi
00002862  53                push ebx
00002863  83EC10            sub esp,byte +0x10
00002866  8B5C2420          mov ebx,[esp+0x20]
0000286A  E805E8FFFF        call dword 0x1074
0000286F  FA                cli
00002870  80FB09            cmp bl,0x9
00002873  0F8417010000      jz dword 0x2990
00002879  80FB0A            cmp bl,0xa
0000287C  7452              jz 0x28d0
0000287E  80FB0D            cmp bl,0xd
00002881  0F8489000000      jz dword 0x2910
00002887  8B354C331000      mov esi,[dword 0x10334c]
0000288D  0FB63D40331000    movzx edi,byte [dword 0x103340]
00002894  0FB6DB            movzx ebx,bl
00002897  8B0D44331000      mov ecx,[dword 0x103344]
0000289D  8D14B6            lea edx,[esi+esi*4]
000028A0  C1E708            shl edi,byte 0x8
000028A3  09FB              or ebx,edi
000028A5  C1E204            shl edx,byte 0x4
000028A8  8B3D48331000      mov edi,[dword 0x103348]
000028AE  01CA              add edx,ecx
000028B0  83C101            add ecx,byte +0x1
000028B3  83F950            cmp ecx,byte +0x50
000028B6  66891C57          mov [edi+edx*2],bx
000028BA  0F84A0000000      jz dword 0x2960
000028C0  890D44331000      mov [dword 0x103344],ecx
000028C6  50                push eax
000028C7  9D                popfd
000028C8  83C410            add esp,byte +0x10
000028CB  5B                pop ebx
000028CC  5E                pop esi
000028CD  5F                pop edi
000028CE  C3                ret
000028CF  90                nop
000028D0  8B354C331000      mov esi,[dword 0x10334c]
000028D6  C705443310000000  mov dword [dword 0x103344],0x0
         -0000
000028E0  8D5601            lea edx,[esi+0x1]
000028E3  83FA19            cmp edx,byte +0x19
000028E6  89154C331000      mov [dword 0x10334c],edx
000028EC  75D8              jnz 0x28c6
000028EE  8944240C          mov [esp+0xc],eax
000028F2  E809FFFFFF        call dword 0x2800
000028F7  832D4C33100001    sub dword [dword 0x10334c],byte +0x1
000028FE  8B44240C          mov eax,[esp+0xc]
00002902  EBC2              jmp short 0x28c6
00002904  8DB600000000      lea esi,[esi+0x0]
0000290A  8DBF00000000      lea edi,[edi+0x0]
00002910  8B0D44331000      mov ecx,[dword 0x103344]
00002916  85C9              test ecx,ecx
00002918  7433              jz 0x294d
0000291A  8B154C331000      mov edx,[dword 0x10334c]
00002920  8B1D48331000      mov ebx,[dword 0x103348]
00002926  8D1492            lea edx,[edx+edx*4]
00002929  89D6              mov esi,edx
0000292B  C1E205            shl edx,byte 0x5
0000292E  C1E604            shl esi,byte 0x4
00002931  01DA              add edx,ebx
00002933  01F1              add ecx,esi
00002935  8D0C4B            lea ecx,[ebx+ecx*2]
00002938  90                nop
00002939  8DB42600000000    lea esi,[esi+0x0]
00002940  31DB              xor ebx,ebx
00002942  83C202            add edx,byte +0x2
00002945  66895AFE          mov [edx-0x2],bx
00002949  39CA              cmp edx,ecx
0000294B  75F3              jnz 0x2940
0000294D  C705443310000000  mov dword [dword 0x103344],0x0
         -0000
00002957  E96AFFFFFF        jmp dword 0x28c6
0000295C  8D742600          lea esi,[esi+0x0]
00002960  83C601            add esi,byte +0x1
00002963  C705443310000000  mov dword [dword 0x103344],0x0
         -0000
0000296D  83FE19            cmp esi,byte +0x19
00002970  89354C331000      mov [dword 0x10334c],esi
00002976  0F854AFFFFFF      jnz dword 0x28c6
0000297C  E96DFFFFFF        jmp dword 0x28ee
00002981  EB0D              jmp short 0x2990
00002983  90                nop
00002984  90                nop
00002985  90                nop
00002986  90                nop
00002987  90                nop
00002988  90                nop
00002989  90                nop
0000298A  90                nop
0000298B  90                nop
0000298C  90                nop
0000298D  90                nop
0000298E  90                nop
0000298F  90                nop
00002990  8944240C          mov [esp+0xc],eax
00002994  83EC0C            sub esp,byte +0xc
00002997  6A20              push byte +0x20
00002999  E8C2FEFFFF        call dword 0x2860
0000299E  C7042420000000    mov dword [esp],0x20
000029A5  E8B6FEFFFF        call dword 0x2860
000029AA  8B44241C          mov eax,[esp+0x1c]
000029AE  50                push eax
000029AF  9D                popfd
000029B0  83C410            add esp,byte +0x10
000029B3  E910FFFFFF        jmp dword 0x28c8
000029B8  90                nop
000029B9  8DB42600000000    lea esi,[esi+0x0]
000029C0  56                push esi
000029C1  53                push ebx
000029C2  83EC10            sub esp,byte +0x10
000029C5  8B5C241C          mov ebx,[esp+0x1c]
000029C9  53                push ebx
000029CA  E8C1F6FFFF        call dword 0x2090
000029CF  83C410            add esp,byte +0x10
000029D2  85C0              test eax,eax
000029D4  8D3403            lea esi,[ebx+eax]
000029D7  741D              jz 0x29f6
000029D9  8DB42600000000    lea esi,[esi+0x0]
000029E0  0FB603            movzx eax,byte [ebx]
000029E3  83EC0C            sub esp,byte +0xc
000029E6  83C301            add ebx,byte +0x1
000029E9  50                push eax
000029EA  E871FEFFFF        call dword 0x2860
000029EF  83C410            add esp,byte +0x10
000029F2  39F3              cmp ebx,esi
000029F4  75EA              jnz 0x29e0
000029F6  83C404            add esp,byte +0x4
000029F9  5B                pop ebx
000029FA  5E                pop esi
000029FB  C3                ret
000029FC  6690              xchg ax,ax
000029FE  6690              xchg ax,ax
00002A00  31C0              xor eax,eax
00002A02  C3                ret
00002A03  8DB600000000      lea esi,[esi+0x0]
00002A09  8DBC2700000000    lea edi,[edi+0x0]
00002A10  55                push ebp
00002A11  57                push edi
00002A12  56                push esi
00002A13  53                push ebx
00002A14  83EC04            sub esp,byte +0x4
00002A17  E460              in al,0x60
00002A19  84C0              test al,al
00002A1B  89C1              mov ecx,eax
00002A1D  8B3D8C331000      mov edi,[dword 0x10338c]
00002A23  8B35C0351000      mov esi,[dword 0x1035c0]
00002A29  8B1D80331000      mov ebx,[dword 0x103380]
00002A2F  7566              jnz 0x2a97
00002A31  E92C010000        jmp dword 0x2b62
00002A36  8D7600            lea esi,[esi+0x0]
00002A39  8DBC2700000000    lea edi,[edi+0x0]
00002A40  80FA1D            cmp dl,0x1d
00002A43  0F84E7000000      jz dword 0x2b30
00002A49  80FA2A            cmp dl,0x2a
00002A4C  B820000000        mov eax,0x20
00002A51  756D              jnz 0x2ac0
00002A53  84C9              test cl,cl
00002A55  0F88B2000000      js dword 0x2b0d
00002A5B  09C7              or edi,eax
00002A5D  80FA45            cmp dl,0x45
00002A60  0F84DA000000      jz dword 0x2b40
00002A66  8D7600            lea esi,[esi+0x0]
00002A69  8DBC2700000000    lea edi,[edi+0x0]
00002A70  38D1              cmp cl,dl
00002A72  0FB6C2            movzx eax,dl
00002A75  888B40361000      mov [ebx+0x103640],cl
00002A7B  0F9580C0341000    setnz [eax+0x1034c0]
00002A82  83C301            add ebx,byte +0x1
00002A85  81E3FF030000      and ebx,0x3ff
00002A8B  E460              in al,0x60
00002A8D  38C8              cmp al,cl
00002A8F  0F84BB000000      jz dword 0x2b50
00002A95  89C1              mov ecx,eax
00002A97  89CA              mov edx,ecx
00002A99  83E27F            and edx,byte +0x7f
00002A9C  80FA36            cmp dl,0x36
00002A9F  745F              jz 0x2b00
00002AA1  769D              jna 0x2a40
00002AA3  80FA38            cmp dl,0x38
00002AA6  7478              jz 0x2b20
00002AA8  80FA5B            cmp dl,0x5b
00002AAB  7513              jnz 0x2ac0
00002AAD  84C9              test cl,cl
00002AAF  B880000000        mov eax,0x80
00002AB4  79A5              jns 0x2a5b
00002AB6  81E77FFFFFFF      and edi,0xffffff7f
00002ABC  EBB2              jmp short 0x2a70
00002ABE  6690              xchg ax,ax
00002AC0  80FA3A            cmp dl,0x3a
00002AC3  742B              jz 0x2af0
00002AC5  80FA45            cmp dl,0x45
00002AC8  75A6              jnz 0x2a70
00002ACA  89CD              mov ebp,ecx
00002ACC  83E580            and ebp,byte -0x80
00002ACF  B804000000        mov eax,0x4
00002AD4  31F0              xor eax,esi
00002AD6  890424            mov [esp],eax
00002AD9  89E8              mov eax,ebp
00002ADB  84C0              test al,al
00002ADD  0F453424          cmovnz esi,[esp]
00002AE1  EB8D              jmp short 0x2a70
00002AE3  8DB600000000      lea esi,[esi+0x0]
00002AE9  8DBC2700000000    lea edi,[edi+0x0]
00002AF0  89CD              mov ebp,ecx
00002AF2  B830000000        mov eax,0x30
00002AF7  83E580            and ebp,byte -0x80
00002AFA  EBD8              jmp short 0x2ad4
00002AFC  8D742600          lea esi,[esi+0x0]
00002B00  84C9              test cl,cl
00002B02  B810000000        mov eax,0x10
00002B07  0F894EFFFFFF      jns dword 0x2a5b
00002B0D  F7D0              not eax
00002B0F  21C7              and edi,eax
00002B11  E95AFFFFFF        jmp dword 0x2a70
00002B16  8D7600            lea esi,[esi+0x0]
00002B19  8DBC2700000000    lea edi,[edi+0x0]
00002B20  B808000000        mov eax,0x8
00002B25  E929FFFFFF        jmp dword 0x2a53
00002B2A  8DB600000000      lea esi,[esi+0x0]
00002B30  B802000000        mov eax,0x2
00002B35  E919FFFFFF        jmp dword 0x2a53
00002B3A  8DB600000000      lea esi,[esi+0x0]
00002B40  31ED              xor ebp,ebp
00002B42  EB8B              jmp short 0x2acf
00002B44  8DB600000000      lea esi,[esi+0x0]
00002B4A  8DBF00000000      lea edi,[edi+0x0]
00002B50  893D8C331000      mov [dword 0x10338c],edi
00002B56  8935C0351000      mov [dword 0x1035c0],esi
00002B5C  891D80331000      mov [dword 0x103380],ebx
00002B62  83C404            add esp,byte +0x4
00002B65  5B                pop ebx
00002B66  5E                pop esi
00002B67  5F                pop edi
00002B68  5D                pop ebp
00002B69  C3                ret
00002B6A  8DB600000000      lea esi,[esi+0x0]
00002B70  83EC0C            sub esp,byte +0xc
00002B73  E8FCE4FFFF        call dword 0x1074
00002B78  FA                cli
00002B79  8B1588331000      mov edx,[dword 0x103388]
00002B7F  3B1580331000      cmp edx,[dword 0x103380]
00002B85  7429              jz 0x2bb0
00002B87  0FB68A40361000    movzx ecx,byte [edx+0x103640]
00002B8E  83C201            add edx,byte +0x1
00002B91  81E2FF030000      and edx,0x3ff
00002B97  891588331000      mov [dword 0x103388],edx
00002B9D  50                push eax
00002B9E  9D                popfd
00002B9F  89C8              mov eax,ecx
00002BA1  83C40C            add esp,byte +0xc
00002BA4  C3                ret
00002BA5  8D742600          lea esi,[esi+0x0]
00002BA9  8DBC2700000000    lea edi,[edi+0x0]
00002BB0  50                push eax
00002BB1  9D                popfd
00002BB2  B8FFFFFFFF        mov eax,0xffffffff
00002BB7  EBE8              jmp short 0x2ba1
00002BB9  8DB42600000000    lea esi,[esi+0x0]
00002BC0  A1C0351000        mov eax,[0x1035c0]
00002BC5  83E030            and eax,byte +0x30
00002BC8  33058C331000      xor eax,[dword 0x10338c]
00002BCE  C3                ret
00002BCF  90                nop
00002BD0  53                push ebx
00002BD1  83EC14            sub esp,byte +0x14
00002BD4  8B5C241C          mov ebx,[esp+0x1c]
00002BD8  53                push ebx
00002BD9  E892F7FFFF        call dword 0x2370
00002BDE  83C410            add esp,byte +0x10
00002BE1  85C0              test eax,eax
00002BE3  BA01000000        mov edx,0x1
00002BE8  7519              jnz 0x2c03
00002BEA  83FB0D            cmp ebx,byte +0xd
00002BED  7414              jz 0x2c03
00002BEF  8D43F7            lea eax,[ebx-0x9]
00002BF2  83F801            cmp eax,byte +0x1
00002BF5  0F96C2            setna dl
00002BF8  83FB20            cmp ebx,byte +0x20
00002BFB  0F94C0            setz al
00002BFE  09C2              or edx,eax
00002C00  0FB6D2            movzx edx,dl
00002C03  83C408            add esp,byte +0x8
00002C06  89D0              mov eax,edx
00002C08  5B                pop ebx
00002C09  C3                ret
00002C0A  8DB600000000      lea esi,[esi+0x0]
00002C10  53                push ebx
00002C11  83EC08            sub esp,byte +0x8
00002C14  E857FFFFFF        call dword 0x2b70
00002C19  6685C0            test ax,ax
00002C1C  7862              js 0x2c80
00002C1E  A880              test al,0x80
00002C20  745E              jz 0x2c80
00002C22  89C3              mov ebx,eax
00002C24  83EC0C            sub esp,byte +0xc
00002C27  83E37F            and ebx,byte +0x7f
00002C2A  0FB683C0331000    movzx eax,byte [ebx+0x1033c0]
00002C31  50                push eax
00002C32  E899FFFFFF        call dword 0x2bd0
00002C37  83C410            add esp,byte +0x10
00002C3A  85C0              test eax,eax
00002C3C  7442              jz 0x2c80
00002C3E  8B15C0351000      mov edx,[dword 0x1035c0]
00002C44  33158C331000      xor edx,[dword 0x10338c]
00002C4A  0FB683C0331000    movzx eax,byte [ebx+0x1033c0]
00002C51  83E230            and edx,byte +0x30
00002C54  740A              jz 0x2c60
00002C56  83C408            add esp,byte +0x8
00002C59  5B                pop ebx
00002C5A  C3                ret
00002C5B  90                nop
00002C5C  8D742600          lea esi,[esi+0x0]
00002C60  83EC0C            sub esp,byte +0xc
00002C63  50                push eax
00002C64  E8B7F6FFFF        call dword 0x2320
00002C69  83C410            add esp,byte +0x10
00002C6C  83C408            add esp,byte +0x8
00002C6F  5B                pop ebx
00002C70  C3                ret
00002C71  EB0D              jmp short 0x2c80
00002C73  90                nop
00002C74  90                nop
00002C75  90                nop
00002C76  90                nop
00002C77  90                nop
00002C78  90                nop
00002C79  90                nop
00002C7A  90                nop
00002C7B  90                nop
00002C7C  90                nop
00002C7D  90                nop
00002C7E  90                nop
00002C7F  90                nop
00002C80  83C408            add esp,byte +0x8
00002C83  B8FFFFFFFF        mov eax,0xffffffff
00002C88  5B                pop ebx
00002C89  C3                ret
00002C8A  8DB600000000      lea esi,[esi+0x0]
00002C90  53                push ebx
00002C91  83EC08            sub esp,byte +0x8
00002C94  E8D7FEFFFF        call dword 0x2b70
00002C99  EB0A              jmp short 0x2ca5
00002C9B  90                nop
00002C9C  8D742600          lea esi,[esi+0x0]
00002CA0  E8CBFEFFFF        call dword 0x2b70
00002CA5  6685C0            test ax,ax
00002CA8  78F6              js 0x2ca0
00002CAA  A880              test al,0x80
00002CAC  74F2              jz 0x2ca0
00002CAE  89C3              mov ebx,eax
00002CB0  83EC0C            sub esp,byte +0xc
00002CB3  83E37F            and ebx,byte +0x7f
00002CB6  0FB683C0331000    movzx eax,byte [ebx+0x1033c0]
00002CBD  50                push eax
00002CBE  E80DFFFFFF        call dword 0x2bd0
00002CC3  83C410            add esp,byte +0x10
00002CC6  85C0              test eax,eax
00002CC8  74D6              jz 0x2ca0
00002CCA  8B15C0351000      mov edx,[dword 0x1035c0]
00002CD0  33158C331000      xor edx,[dword 0x10338c]
00002CD6  0FB683C0331000    movzx eax,byte [ebx+0x1033c0]
00002CDD  83E230            and edx,byte +0x30
00002CE0  750C              jnz 0x2cee
00002CE2  83EC0C            sub esp,byte +0xc
00002CE5  50                push eax
00002CE6  E835F6FFFF        call dword 0x2320
00002CEB  83C410            add esp,byte +0x10
00002CEE  83C408            add esp,byte +0x8
00002CF1  5B                pop ebx
00002CF2  C3                ret
00002CF3  8DB600000000      lea esi,[esi+0x0]
00002CF9  8DBC2700000000    lea edi,[edi+0x0]
00002D00  C6058433100000    mov byte [dword 0x103384],0x0
00002D07  31C0              xor eax,eax
00002D09  8DB42600000000    lea esi,[esi+0x0]
00002D10  C680C033100000    mov byte [eax+0x1033c0],0x0
00002D17  83C001            add eax,byte +0x1
00002D1A  3DFF000000        cmp eax,0xff
00002D1F  75EF              jnz 0x2d10
00002D21  C605EB3310005C    mov byte [dword 0x1033eb],0x5c
00002D28  B010              mov al,0x10
00002D2A  8DB600000000      lea esi,[esi+0x0]
00002D30  0FB69047E31000    movzx edx,byte [eax+0x10e347]
00002D37  83C001            add eax,byte +0x1
00002D3A  8890BF331000      mov [eax+0x1033bf],dl
00002D40  83F81C            cmp eax,byte +0x1c
00002D43  75EB              jnz 0x2d30
00002D45  B01E              mov al,0x1e
00002D47  89F6              mov esi,esi
00002D49  8DBC2700000000    lea edi,[edi+0x0]
00002D50  0FB69046E31000    movzx edx,byte [eax+0x10e346]
00002D57  83C001            add eax,byte +0x1
00002D5A  8890BF331000      mov [eax+0x1033bf],dl
00002D60  83F829            cmp eax,byte +0x29
00002D63  75EB              jnz 0x2d50
00002D65  B02C              mov al,0x2c
00002D67  89F6              mov esi,esi
00002D69  8DBC2700000000    lea edi,[edi+0x0]
00002D70  0FB69044E31000    movzx edx,byte [eax+0x10e344]
00002D77  83C001            add eax,byte +0x1
00002D7A  8890BF331000      mov [eax+0x1033bf],dl
00002D80  83F836            cmp eax,byte +0x36
00002D83  75EB              jnz 0x2d70
00002D85  B002              mov al,0x2
00002D87  89F6              mov esi,esi
00002D89  8DBC2700000000    lea edi,[edi+0x0]
00002D90  0FB69079E31000    movzx edx,byte [eax+0x10e379]
00002D97  83C001            add eax,byte +0x1
00002D9A  8890BF331000      mov [eax+0x1033bf],dl
00002DA0  83F80E            cmp eax,byte +0xe
00002DA3  75EB              jnz 0x2d90
00002DA5  83EC10            sub esp,byte +0x10
00002DA8  C605E933100060    mov byte [dword 0x1033e9],0x60
00002DAF  C605CF33100009    mov byte [dword 0x1033cf],0x9
00002DB6  68FF000000        push dword 0xff
00002DBB  6A00              push byte +0x0
00002DBD  68C0341000        push dword 0x1034c0
00002DC2  C605DC3310000A    mov byte [dword 0x1033dc],0xa
00002DC9  C605F933100020    mov byte [dword 0x1033f9],0x20
00002DD0  E81BF3FFFF        call dword 0x20f0
00002DD5  58                pop eax
00002DD6  5A                pop edx
00002DD7  68001A1000        push dword 0x101a00
00002DDC  6A01              push byte +0x1
00002DDE  C705C03510000000  mov dword [dword 0x1035c0],0x0
         -0000
00002DE8  C7058C3310000000  mov dword [dword 0x10338c],0x0
         -0000
00002DF2  E859F2FFFF        call dword 0x2050
00002DF7  C705803310000000  mov dword [dword 0x103380],0x0
         -0000
00002E01  C705883310000000  mov dword [dword 0x103388],0x0
         -0000
00002E0B  83C41C            add esp,byte +0x1c
00002E0E  C3                ret
00002E0F  0000              add [eax],al
00002E11  0000              add [eax],al
00002E13  0000              add [eax],al
00002E15  0000              add [eax],al
00002E17  0000              add [eax],al
00002E19  0000              add [eax],al
00002E1B  0000              add [eax],al
00002E1D  0000              add [eax],al
00002E1F  0000              add [eax],al
00002E21  0000              add [eax],al
00002E23  0000              add [eax],al
00002E25  0000              add [eax],al
00002E27  0000              add [eax],al
00002E29  0000              add [eax],al
00002E2B  0000              add [eax],al
00002E2D  0000              add [eax],al
00002E2F  0000              add [eax],al
00002E31  0000              add [eax],al
00002E33  0000              add [eax],al
00002E35  0000              add [eax],al
00002E37  0000              add [eax],al
00002E39  0000              add [eax],al
00002E3B  0000              add [eax],al
00002E3D  0000              add [eax],al
00002E3F  0000              add [eax],al
00002E41  0000              add [eax],al
00002E43  0000              add [eax],al
00002E45  0000              add [eax],al
00002E47  0000              add [eax],al
00002E49  0000              add [eax],al
00002E4B  0000              add [eax],al
00002E4D  0000              add [eax],al
00002E4F  0000              add [eax],al
00002E51  0000              add [eax],al
00002E53  0000              add [eax],al
00002E55  0000              add [eax],al
00002E57  0000              add [eax],al
00002E59  0000              add [eax],al
00002E5B  0000              add [eax],al
00002E5D  0000              add [eax],al
00002E5F  0000              add [eax],al
00002E61  0000              add [eax],al
00002E63  0000              add [eax],al
00002E65  0000              add [eax],al
00002E67  0000              add [eax],al
00002E69  0000              add [eax],al
00002E6B  0000              add [eax],al
00002E6D  0000              add [eax],al
00002E6F  0000              add [eax],al
00002E71  0000              add [eax],al
00002E73  0000              add [eax],al
00002E75  0000              add [eax],al
00002E77  0000              add [eax],al
00002E79  0000              add [eax],al
00002E7B  0000              add [eax],al
00002E7D  0000              add [eax],al
00002E7F  0000              add [eax],al
00002E81  0000              add [eax],al
00002E83  0000              add [eax],al
00002E85  0000              add [eax],al
00002E87  0000              add [eax],al
00002E89  0000              add [eax],al
00002E8B  0000              add [eax],al
00002E8D  0000              add [eax],al
00002E8F  0000              add [eax],al
00002E91  0000              add [eax],al
00002E93  0000              add [eax],al
00002E95  0000              add [eax],al
00002E97  0000              add [eax],al
00002E99  0000              add [eax],al
00002E9B  0000              add [eax],al
00002E9D  0000              add [eax],al
00002E9F  0000              add [eax],al
00002EA1  0000              add [eax],al
00002EA3  0000              add [eax],al
00002EA5  0000              add [eax],al
00002EA7  0000              add [eax],al
00002EA9  0000              add [eax],al
00002EAB  0000              add [eax],al
00002EAD  0000              add [eax],al
00002EAF  0000              add [eax],al
00002EB1  0000              add [eax],al
00002EB3  0000              add [eax],al
00002EB5  0000              add [eax],al
00002EB7  0000              add [eax],al
00002EB9  0000              add [eax],al
00002EBB  0000              add [eax],al
00002EBD  0000              add [eax],al
00002EBF  0000              add [eax],al
00002EC1  0000              add [eax],al
00002EC3  0000              add [eax],al
00002EC5  0000              add [eax],al
00002EC7  0000              add [eax],al
00002EC9  0000              add [eax],al
00002ECB  0000              add [eax],al
00002ECD  0000              add [eax],al
00002ECF  0000              add [eax],al
00002ED1  0000              add [eax],al
00002ED3  0000              add [eax],al
00002ED5  0000              add [eax],al
00002ED7  0000              add [eax],al
00002ED9  0000              add [eax],al
00002EDB  0000              add [eax],al
00002EDD  0000              add [eax],al
00002EDF  0000              add [eax],al
00002EE1  0000              add [eax],al
00002EE3  0000              add [eax],al
00002EE5  0000              add [eax],al
00002EE7  0000              add [eax],al
00002EE9  0000              add [eax],al
00002EEB  0000              add [eax],al
00002EED  0000              add [eax],al
00002EEF  0000              add [eax],al
00002EF1  0000              add [eax],al
00002EF3  0000              add [eax],al
00002EF5  0000              add [eax],al
00002EF7  0000              add [eax],al
00002EF9  0000              add [eax],al
00002EFB  0000              add [eax],al
00002EFD  0000              add [eax],al
00002EFF  0000              add [eax],al
00002F01  0000              add [eax],al
00002F03  0000              add [eax],al
00002F05  0000              add [eax],al
00002F07  0000              add [eax],al
00002F09  0000              add [eax],al
00002F0B  0000              add [eax],al
00002F0D  0000              add [eax],al
00002F0F  0000              add [eax],al
00002F11  0000              add [eax],al
00002F13  0000              add [eax],al
00002F15  0000              add [eax],al
00002F17  0000              add [eax],al
00002F19  0000              add [eax],al
00002F1B  0000              add [eax],al
00002F1D  0000              add [eax],al
00002F1F  0000              add [eax],al
00002F21  0000              add [eax],al
00002F23  0000              add [eax],al
00002F25  0000              add [eax],al
00002F27  0000              add [eax],al
00002F29  0000              add [eax],al
00002F2B  0000              add [eax],al
00002F2D  0000              add [eax],al
00002F2F  0000              add [eax],al
00002F31  0000              add [eax],al
00002F33  0000              add [eax],al
00002F35  0000              add [eax],al
00002F37  0000              add [eax],al
00002F39  0000              add [eax],al
00002F3B  0000              add [eax],al
00002F3D  0000              add [eax],al
00002F3F  0000              add [eax],al
00002F41  0000              add [eax],al
00002F43  0000              add [eax],al
00002F45  0000              add [eax],al
00002F47  0000              add [eax],al
00002F49  0000              add [eax],al
00002F4B  0000              add [eax],al
00002F4D  0000              add [eax],al
00002F4F  0000              add [eax],al
00002F51  0000              add [eax],al
00002F53  0000              add [eax],al
00002F55  0000              add [eax],al
00002F57  0000              add [eax],al
00002F59  0000              add [eax],al
00002F5B  0000              add [eax],al
00002F5D  0000              add [eax],al
00002F5F  0000              add [eax],al
00002F61  0000              add [eax],al
00002F63  0000              add [eax],al
00002F65  0000              add [eax],al
00002F67  0000              add [eax],al
00002F69  0000              add [eax],al
00002F6B  0000              add [eax],al
00002F6D  0000              add [eax],al
00002F6F  0000              add [eax],al
00002F71  0000              add [eax],al
00002F73  0000              add [eax],al
00002F75  0000              add [eax],al
00002F77  0000              add [eax],al
00002F79  0000              add [eax],al
00002F7B  0000              add [eax],al
00002F7D  0000              add [eax],al
00002F7F  0000              add [eax],al
00002F81  0000              add [eax],al
00002F83  0000              add [eax],al
00002F85  0000              add [eax],al
00002F87  0000              add [eax],al
00002F89  0000              add [eax],al
00002F8B  0000              add [eax],al
00002F8D  0000              add [eax],al
00002F8F  0000              add [eax],al
00002F91  0000              add [eax],al
00002F93  0000              add [eax],al
00002F95  0000              add [eax],al
00002F97  0000              add [eax],al
00002F99  0000              add [eax],al
00002F9B  0000              add [eax],al
00002F9D  0000              add [eax],al
00002F9F  0000              add [eax],al
00002FA1  0000              add [eax],al
00002FA3  0000              add [eax],al
00002FA5  0000              add [eax],al
00002FA7  0000              add [eax],al
00002FA9  0000              add [eax],al
00002FAB  0000              add [eax],al
00002FAD  0000              add [eax],al
00002FAF  0000              add [eax],al
00002FB1  0000              add [eax],al
00002FB3  0000              add [eax],al
00002FB5  0000              add [eax],al
00002FB7  0000              add [eax],al
00002FB9  0000              add [eax],al
00002FBB  0000              add [eax],al
00002FBD  0000              add [eax],al
00002FBF  0000              add [eax],al
00002FC1  0000              add [eax],al
00002FC3  0000              add [eax],al
00002FC5  0000              add [eax],al
00002FC7  0000              add [eax],al
00002FC9  0000              add [eax],al
00002FCB  0000              add [eax],al
00002FCD  0000              add [eax],al
00002FCF  0000              add [eax],al
00002FD1  0000              add [eax],al
00002FD3  0000              add [eax],al
00002FD5  0000              add [eax],al
00002FD7  0000              add [eax],al
00002FD9  0000              add [eax],al
00002FDB  0000              add [eax],al
00002FDD  0000              add [eax],al
00002FDF  0000              add [eax],al
00002FE1  0000              add [eax],al
00002FE3  0000              add [eax],al
00002FE5  0000              add [eax],al
00002FE7  0000              add [eax],al
00002FE9  0000              add [eax],al
00002FEB  0000              add [eax],al
00002FED  0000              add [eax],al
00002FEF  0000              add [eax],al
00002FF1  0000              add [eax],al
00002FF3  0000              add [eax],al
00002FF5  0000              add [eax],al
00002FF7  0000              add [eax],al
00002FF9  0000              add [eax],al
00002FFB  0000              add [eax],al
00002FFD  0000              add [eax],al
00002FFF  0000              add [eax],al
00003001  0000              add [eax],al
00003003  0000              add [eax],al
00003005  00FA              add dl,bh
00003007  50                push eax
00003008  53                push ebx
00003009  B8707A1000        mov eax,0x107a70
0000300E  A302901000        mov [0x109002],eax
00003013  66B8FF07          mov ax,0x7ff
00003017  66A300901000      mov [0x109000],ax
0000301D  0F011D00901000    lidt [dword 0x109000]
00003024  5B                pop ebx
00003025  58                pop eax
00003026  C3                ret
00003027  FA                cli
00003028  60                pushad
00003029  9C                pushfd
0000302A  FC                cld
0000302B  E8E089FFFF        call dword 0xffffba10
00003030  B020              mov al,0x20
00003032  E620              out 0x20,al
00003034  9D                popfd
00003035  61                popad
00003036  FB                sti
00003037  CF                iretd
00003038  FA                cli
00003039  60                pushad
0000303A  9C                pushfd
0000303B  FC                cld
0000303C  E87F7EFFFF        call dword 0xffffaec0
00003041  B020              mov al,0x20
00003043  E620              out 0x20,al
00003045  9D                popfd
00003046  61                popad
00003047  FB                sti
00003048  CF                iretd
00003049  FA                cli
0000304A  60                pushad
0000304B  9C                pushfd
0000304C  FC                cld
0000304D  E87E7EFFFF        call dword 0xffffaed0
00003052  B020              mov al,0x20
00003054  E620              out 0x20,al
00003056  9D                popfd
00003057  61                popad
00003058  FB                sti
00003059  CF                iretd
0000305A  FA                cli
0000305B  60                pushad
0000305C  9C                pushfd
0000305D  FC                cld
0000305E  E87D7EFFFF        call dword 0xffffaee0
00003063  B020              mov al,0x20
00003065  E620              out 0x20,al
00003067  9D                popfd
00003068  61                popad
00003069  FB                sti
0000306A  CF                iretd
0000306B  FA                cli
0000306C  60                pushad
0000306D  9C                pushfd
0000306E  FC                cld
0000306F  E87C7EFFFF        call dword 0xffffaef0
00003074  B020              mov al,0x20
00003076  E620              out 0x20,al
00003078  9D                popfd
00003079  61                popad
0000307A  FB                sti
0000307B  CF                iretd
0000307C  FA                cli
0000307D  60                pushad
0000307E  9C                pushfd
0000307F  FC                cld
00003080  E87B7EFFFF        call dword 0xffffaf00
00003085  B020              mov al,0x20
00003087  E620              out 0x20,al
00003089  9D                popfd
0000308A  61                popad
0000308B  FB                sti
0000308C  CF                iretd
0000308D  FA                cli
0000308E  60                pushad
0000308F  9C                pushfd
00003090  FC                cld
00003091  E87A7EFFFF        call dword 0xffffaf10
00003096  B020              mov al,0x20
00003098  E620              out 0x20,al
0000309A  9D                popfd
0000309B  61                popad
0000309C  FB                sti
0000309D  CF                iretd
0000309E  FA                cli
0000309F  60                pushad
000030A0  9C                pushfd
000030A1  FC                cld
000030A2  E8797EFFFF        call dword 0xffffaf20
000030A7  B020              mov al,0x20
000030A9  E6A0              out 0xa0,al
000030AB  9D                popfd
000030AC  61                popad
000030AD  FB                sti
000030AE  CF                iretd
000030AF  FA                cli
000030B0  60                pushad
000030B1  9C                pushfd
000030B2  FC                cld
000030B3  E8787EFFFF        call dword 0xffffaf30
000030B8  B020              mov al,0x20
000030BA  E6A0              out 0xa0,al
000030BC  9D                popfd
000030BD  61                popad
000030BE  FB                sti
000030BF  CF                iretd
000030C0  FA                cli
000030C1  60                pushad
000030C2  9C                pushfd
000030C3  FC                cld
000030C4  E8777EFFFF        call dword 0xffffaf40
000030C9  B020              mov al,0x20
000030CB  E6A0              out 0xa0,al
000030CD  9D                popfd
000030CE  61                popad
000030CF  FB                sti
000030D0  CF                iretd
000030D1  FA                cli
000030D2  60                pushad
000030D3  9C                pushfd
000030D4  FC                cld
000030D5  E8767EFFFF        call dword 0xffffaf50
000030DA  B020              mov al,0x20
000030DC  E6A0              out 0xa0,al
000030DE  9D                popfd
000030DF  61                popad
000030E0  FB                sti
000030E1  CF                iretd
000030E2  FA                cli
000030E3  60                pushad
000030E4  9C                pushfd
000030E5  FC                cld
000030E6  E8757EFFFF        call dword 0xffffaf60
000030EB  B020              mov al,0x20
000030ED  E6A0              out 0xa0,al
000030EF  9D                popfd
000030F0  61                popad
000030F1  FB                sti
000030F2  CF                iretd
000030F3  FA                cli
000030F4  60                pushad
000030F5  9C                pushfd
000030F6  FC                cld
000030F7  E8747EFFFF        call dword 0xffffaf70
000030FC  B020              mov al,0x20
000030FE  E6A0              out 0xa0,al
00003100  9D                popfd
00003101  61                popad
00003102  FB                sti
00003103  CF                iretd
00003104  FA                cli
00003105  60                pushad
00003106  9C                pushfd
00003107  FC                cld
00003108  E8737EFFFF        call dword 0xffffaf80
0000310D  B020              mov al,0x20
0000310F  E6A0              out 0xa0,al
00003111  9D                popfd
00003112  61                popad
00003113  FB                sti
00003114  CF                iretd
00003115  FA                cli
00003116  60                pushad
00003117  9C                pushfd
00003118  FC                cld
00003119  E8727EFFFF        call dword 0xffffaf90
0000311E  B020              mov al,0x20
00003120  E6A0              out 0xa0,al
00003122  9D                popfd
00003123  61                popad
00003124  FB                sti
00003125  CF                iretd
00003126  90                nop
00003127  90                nop
00003128  0000              add [eax],al
0000312A  0000              add [eax],al
0000312C  0000              add [eax],al
0000312E  0000              add [eax],al
00003130  0000              add [eax],al
00003132  0000              add [eax],al
00003134  0000              add [eax],al
00003136  0000              add [eax],al
00003138  0000              add [eax],al
0000313A  0000              add [eax],al
0000313C  0000              add [eax],al
0000313E  0000              add [eax],al
00003140  0000              add [eax],al
00003142  0000              add [eax],al
00003144  0000              add [eax],al
00003146  0000              add [eax],al
00003148  0000              add [eax],al
0000314A  0000              add [eax],al
0000314C  0000              add [eax],al
0000314E  0000              add [eax],al
00003150  0000              add [eax],al
00003152  0000              add [eax],al
00003154  0000              add [eax],al
00003156  0000              add [eax],al
00003158  0000              add [eax],al
0000315A  0000              add [eax],al
0000315C  0000              add [eax],al
0000315E  0000              add [eax],al
00003160  0000              add [eax],al
00003162  0000              add [eax],al
00003164  0000              add [eax],al
00003166  0000              add [eax],al
00003168  0000              add [eax],al
0000316A  0000              add [eax],al
0000316C  0000              add [eax],al
0000316E  0000              add [eax],al
00003170  0000              add [eax],al
00003172  0000              add [eax],al
00003174  0000              add [eax],al
00003176  0000              add [eax],al
00003178  0000              add [eax],al
0000317A  0000              add [eax],al
0000317C  0000              add [eax],al
0000317E  0000              add [eax],al
00003180  0000              add [eax],al
00003182  0000              add [eax],al
00003184  0000              add [eax],al
00003186  0000              add [eax],al
00003188  0000              add [eax],al
0000318A  0000              add [eax],al
0000318C  0000              add [eax],al
0000318E  0000              add [eax],al
00003190  0000              add [eax],al
00003192  0000              add [eax],al
00003194  0000              add [eax],al
00003196  0000              add [eax],al
00003198  0000              add [eax],al
0000319A  0000              add [eax],al
0000319C  0000              add [eax],al
0000319E  0000              add [eax],al
000031A0  0000              add [eax],al
000031A2  0000              add [eax],al
000031A4  0000              add [eax],al
000031A6  0000              add [eax],al
000031A8  0000              add [eax],al
000031AA  0000              add [eax],al
000031AC  0000              add [eax],al
000031AE  0000              add [eax],al
000031B0  0000              add [eax],al
000031B2  0000              add [eax],al
000031B4  0000              add [eax],al
000031B6  0000              add [eax],al
000031B8  0000              add [eax],al
000031BA  0000              add [eax],al
000031BC  0000              add [eax],al
000031BE  0000              add [eax],al
000031C0  0000              add [eax],al
000031C2  0000              add [eax],al
000031C4  0000              add [eax],al
000031C6  0000              add [eax],al
000031C8  0000              add [eax],al
000031CA  0000              add [eax],al
000031CC  0000              add [eax],al
000031CE  0000              add [eax],al
000031D0  0000              add [eax],al
000031D2  0000              add [eax],al
000031D4  0000              add [eax],al
000031D6  0000              add [eax],al
000031D8  0000              add [eax],al
000031DA  0000              add [eax],al
000031DC  0000              add [eax],al
000031DE  0000              add [eax],al
000031E0  0000              add [eax],al
000031E2  0000              add [eax],al
000031E4  0000              add [eax],al
000031E6  0000              add [eax],al
000031E8  0000              add [eax],al
000031EA  0000              add [eax],al
000031EC  0000              add [eax],al
000031EE  0000              add [eax],al
000031F0  0000              add [eax],al
000031F2  0000              add [eax],al
000031F4  0000              add [eax],al
000031F6  0000              add [eax],al
000031F8  0000              add [eax],al
000031FA  0000              add [eax],al
000031FC  0000              add [eax],al
000031FE  0000              add [eax],al
00003200  0000              add [eax],al
00003202  0000              add [eax],al
00003204  0000              add [eax],al
00003206  0000              add [eax],al
00003208  0000              add [eax],al
0000320A  0000              add [eax],al
0000320C  0000              add [eax],al
0000320E  0000              add [eax],al
00003210  0000              add [eax],al
00003212  0000              add [eax],al
00003214  0000              add [eax],al
00003216  0000              add [eax],al
00003218  0000              add [eax],al
0000321A  0000              add [eax],al
0000321C  0000              add [eax],al
0000321E  0000              add [eax],al
00003220  0000              add [eax],al
00003222  0000              add [eax],al
00003224  0000              add [eax],al
00003226  0000              add [eax],al
00003228  0000              add [eax],al
0000322A  0000              add [eax],al
0000322C  0000              add [eax],al
0000322E  0000              add [eax],al
00003230  0000              add [eax],al
00003232  0000              add [eax],al
00003234  0000              add [eax],al
00003236  0000              add [eax],al
00003238  0000              add [eax],al
0000323A  0000              add [eax],al
0000323C  0000              add [eax],al
0000323E  0000              add [eax],al
00003240  0000              add [eax],al
00003242  0000              add [eax],al
00003244  0000              add [eax],al
00003246  0000              add [eax],al
00003248  0000              add [eax],al
0000324A  0000              add [eax],al
0000324C  0000              add [eax],al
0000324E  0000              add [eax],al
00003250  0000              add [eax],al
00003252  0000              add [eax],al
00003254  0000              add [eax],al
00003256  0000              add [eax],al
00003258  0000              add [eax],al
0000325A  0000              add [eax],al
0000325C  0000              add [eax],al
0000325E  0000              add [eax],al
00003260  0000              add [eax],al
00003262  0000              add [eax],al
00003264  0000              add [eax],al
00003266  0000              add [eax],al
00003268  0000              add [eax],al
0000326A  0000              add [eax],al
0000326C  0000              add [eax],al
0000326E  0000              add [eax],al
00003270  0000              add [eax],al
00003272  0000              add [eax],al
00003274  0000              add [eax],al
00003276  0000              add [eax],al
00003278  0000              add [eax],al
0000327A  0000              add [eax],al
0000327C  0000              add [eax],al
0000327E  0000              add [eax],al
00003280  0000              add [eax],al
00003282  0000              add [eax],al
00003284  0000              add [eax],al
00003286  0000              add [eax],al
00003288  0000              add [eax],al
0000328A  0000              add [eax],al
0000328C  0000              add [eax],al
0000328E  0000              add [eax],al
00003290  0000              add [eax],al
00003292  0000              add [eax],al
00003294  0000              add [eax],al
00003296  0000              add [eax],al
00003298  0000              add [eax],al
0000329A  0000              add [eax],al
0000329C  0000              add [eax],al
0000329E  0000              add [eax],al
000032A0  0000              add [eax],al
000032A2  0000              add [eax],al
000032A4  0000              add [eax],al
000032A6  0000              add [eax],al
000032A8  0000              add [eax],al
000032AA  0000              add [eax],al
000032AC  0000              add [eax],al
000032AE  0000              add [eax],al
000032B0  0000              add [eax],al
000032B2  0000              add [eax],al
000032B4  0000              add [eax],al
000032B6  0000              add [eax],al
000032B8  0000              add [eax],al
000032BA  0000              add [eax],al
000032BC  0000              add [eax],al
000032BE  0000              add [eax],al
000032C0  0000              add [eax],al
000032C2  0000              add [eax],al
000032C4  0000              add [eax],al
000032C6  0000              add [eax],al
000032C8  0000              add [eax],al
000032CA  0000              add [eax],al
000032CC  0000              add [eax],al
000032CE  0000              add [eax],al
000032D0  0000              add [eax],al
000032D2  0000              add [eax],al
000032D4  0000              add [eax],al
000032D6  0000              add [eax],al
000032D8  0000              add [eax],al
000032DA  0000              add [eax],al
000032DC  0000              add [eax],al
000032DE  0000              add [eax],al
000032E0  0000              add [eax],al
000032E2  0000              add [eax],al
000032E4  0000              add [eax],al
000032E6  0000              add [eax],al
000032E8  0000              add [eax],al
000032EA  0000              add [eax],al
000032EC  0000              add [eax],al
000032EE  0000              add [eax],al
000032F0  0000              add [eax],al
000032F2  0000              add [eax],al
000032F4  0000              add [eax],al
000032F6  0000              add [eax],al
000032F8  0000              add [eax],al
000032FA  0000              add [eax],al
000032FC  0000              add [eax],al
000032FE  0000              add [eax],al
00003300  0000              add [eax],al
00003302  0000              add [eax],al
00003304  0000              add [eax],al
00003306  0000              add [eax],al
00003308  0000              add [eax],al
0000330A  0000              add [eax],al
0000330C  0000              add [eax],al
0000330E  0000              add [eax],al
00003310  0000              add [eax],al
00003312  0000              add [eax],al
00003314  0000              add [eax],al
00003316  0000              add [eax],al
00003318  0000              add [eax],al
0000331A  0000              add [eax],al
0000331C  0000              add [eax],al
0000331E  0000              add [eax],al
00003320  0000              add [eax],al
00003322  0000              add [eax],al
00003324  0000              add [eax],al
00003326  0000              add [eax],al
00003328  0000              add [eax],al
0000332A  0000              add [eax],al
0000332C  0000              add [eax],al
0000332E  0000              add [eax],al
00003330  0000              add [eax],al
00003332  0000              add [eax],al
00003334  0000              add [eax],al
00003336  0000              add [eax],al
00003338  0000              add [eax],al
0000333A  0000              add [eax],al
0000333C  0000              add [eax],al
0000333E  0000              add [eax],al
00003340  0000              add [eax],al
00003342  0000              add [eax],al
00003344  0000              add [eax],al
00003346  0000              add [eax],al
00003348  0000              add [eax],al
0000334A  0000              add [eax],al
0000334C  0000              add [eax],al
0000334E  0000              add [eax],al
00003350  0000              add [eax],al
00003352  0000              add [eax],al
00003354  0000              add [eax],al
00003356  0000              add [eax],al
00003358  0000              add [eax],al
0000335A  0000              add [eax],al
0000335C  0000              add [eax],al
0000335E  0000              add [eax],al
00003360  0000              add [eax],al
00003362  0000              add [eax],al
00003364  0000              add [eax],al
00003366  0000              add [eax],al
00003368  0000              add [eax],al
0000336A  0000              add [eax],al
0000336C  0000              add [eax],al
0000336E  0000              add [eax],al
00003370  0000              add [eax],al
00003372  0000              add [eax],al
00003374  0000              add [eax],al
00003376  0000              add [eax],al
00003378  0000              add [eax],al
0000337A  0000              add [eax],al
0000337C  0000              add [eax],al
0000337E  0000              add [eax],al
00003380  0000              add [eax],al
00003382  0000              add [eax],al
00003384  0000              add [eax],al
00003386  0000              add [eax],al
00003388  0000              add [eax],al
0000338A  0000              add [eax],al
0000338C  0000              add [eax],al
0000338E  0000              add [eax],al
00003390  0000              add [eax],al
00003392  0000              add [eax],al
00003394  0000              add [eax],al
00003396  0000              add [eax],al
00003398  0000              add [eax],al
0000339A  0000              add [eax],al
0000339C  0000              add [eax],al
0000339E  0000              add [eax],al
000033A0  0000              add [eax],al
000033A2  0000              add [eax],al
000033A4  0000              add [eax],al
000033A6  0000              add [eax],al
000033A8  0000              add [eax],al
000033AA  0000              add [eax],al
000033AC  0000              add [eax],al
000033AE  0000              add [eax],al
000033B0  0000              add [eax],al
000033B2  0000              add [eax],al
000033B4  0000              add [eax],al
000033B6  0000              add [eax],al
000033B8  0000              add [eax],al
000033BA  0000              add [eax],al
000033BC  0000              add [eax],al
000033BE  0000              add [eax],al
000033C0  0000              add [eax],al
000033C2  0000              add [eax],al
000033C4  0000              add [eax],al
000033C6  0000              add [eax],al
000033C8  0000              add [eax],al
000033CA  0000              add [eax],al
000033CC  0000              add [eax],al
000033CE  0000              add [eax],al
000033D0  0000              add [eax],al
000033D2  0000              add [eax],al
000033D4  0000              add [eax],al
000033D6  0000              add [eax],al
000033D8  0000              add [eax],al
000033DA  0000              add [eax],al
000033DC  0000              add [eax],al
000033DE  0000              add [eax],al
000033E0  0000              add [eax],al
000033E2  0000              add [eax],al
000033E4  0000              add [eax],al
000033E6  0000              add [eax],al
000033E8  0000              add [eax],al
000033EA  0000              add [eax],al
000033EC  0000              add [eax],al
000033EE  0000              add [eax],al
000033F0  0000              add [eax],al
000033F2  0000              add [eax],al
000033F4  0000              add [eax],al
000033F6  0000              add [eax],al
000033F8  0000              add [eax],al
000033FA  0000              add [eax],al
000033FC  0000              add [eax],al
000033FE  0000              add [eax],al
00003400  0000              add [eax],al
00003402  0000              add [eax],al
00003404  0000              add [eax],al
00003406  0000              add [eax],al
00003408  0000              add [eax],al
0000340A  0000              add [eax],al
0000340C  0000              add [eax],al
0000340E  0000              add [eax],al
00003410  0000              add [eax],al
00003412  0000              add [eax],al
00003414  0000              add [eax],al
00003416  0000              add [eax],al
00003418  0000              add [eax],al
0000341A  0000              add [eax],al
0000341C  0000              add [eax],al
0000341E  0000              add [eax],al
00003420  0000              add [eax],al
00003422  0000              add [eax],al
00003424  0000              add [eax],al
00003426  0000              add [eax],al
00003428  0000              add [eax],al
0000342A  0000              add [eax],al
0000342C  0000              add [eax],al
0000342E  0000              add [eax],al
00003430  0000              add [eax],al
00003432  0000              add [eax],al
00003434  0000              add [eax],al
00003436  0000              add [eax],al
00003438  0000              add [eax],al
0000343A  0000              add [eax],al
0000343C  0000              add [eax],al
0000343E  0000              add [eax],al
00003440  0000              add [eax],al
00003442  0000              add [eax],al
00003444  0000              add [eax],al
00003446  0000              add [eax],al
00003448  0000              add [eax],al
0000344A  0000              add [eax],al
0000344C  0000              add [eax],al
0000344E  0000              add [eax],al
00003450  0000              add [eax],al
00003452  0000              add [eax],al
00003454  0000              add [eax],al
00003456  0000              add [eax],al
00003458  0000              add [eax],al
0000345A  0000              add [eax],al
0000345C  0000              add [eax],al
0000345E  0000              add [eax],al
00003460  0000              add [eax],al
00003462  0000              add [eax],al
00003464  0000              add [eax],al
00003466  0000              add [eax],al
00003468  0000              add [eax],al
0000346A  0000              add [eax],al
0000346C  0000              add [eax],al
0000346E  0000              add [eax],al
00003470  0000              add [eax],al
00003472  0000              add [eax],al
00003474  0000              add [eax],al
00003476  0000              add [eax],al
00003478  0000              add [eax],al
0000347A  0000              add [eax],al
0000347C  0000              add [eax],al
0000347E  0000              add [eax],al
00003480  0000              add [eax],al
00003482  0000              add [eax],al
00003484  0000              add [eax],al
00003486  0000              add [eax],al
00003488  0000              add [eax],al
0000348A  0000              add [eax],al
0000348C  0000              add [eax],al
0000348E  0000              add [eax],al
00003490  0000              add [eax],al
00003492  0000              add [eax],al
00003494  0000              add [eax],al
00003496  0000              add [eax],al
00003498  0000              add [eax],al
0000349A  0000              add [eax],al
0000349C  0000              add [eax],al
0000349E  0000              add [eax],al
000034A0  0000              add [eax],al
000034A2  0000              add [eax],al
000034A4  0000              add [eax],al
000034A6  0000              add [eax],al
000034A8  0000              add [eax],al
000034AA  0000              add [eax],al
000034AC  0000              add [eax],al
000034AE  0000              add [eax],al
000034B0  0000              add [eax],al
000034B2  0000              add [eax],al
000034B4  0000              add [eax],al
000034B6  0000              add [eax],al
000034B8  0000              add [eax],al
000034BA  0000              add [eax],al
000034BC  0000              add [eax],al
000034BE  0000              add [eax],al
000034C0  0000              add [eax],al
000034C2  0000              add [eax],al
000034C4  0000              add [eax],al
000034C6  0000              add [eax],al
000034C8  0000              add [eax],al
000034CA  0000              add [eax],al
000034CC  0000              add [eax],al
000034CE  0000              add [eax],al
000034D0  0000              add [eax],al
000034D2  0000              add [eax],al
000034D4  0000              add [eax],al
000034D6  0000              add [eax],al
000034D8  0000              add [eax],al
000034DA  0000              add [eax],al
000034DC  0000              add [eax],al
000034DE  0000              add [eax],al
000034E0  0000              add [eax],al
000034E2  0000              add [eax],al
000034E4  0000              add [eax],al
000034E6  0000              add [eax],al
000034E8  0000              add [eax],al
000034EA  0000              add [eax],al
000034EC  0000              add [eax],al
000034EE  0000              add [eax],al
000034F0  0000              add [eax],al
000034F2  0000              add [eax],al
000034F4  0000              add [eax],al
000034F6  0000              add [eax],al
000034F8  0000              add [eax],al
000034FA  0000              add [eax],al
000034FC  0000              add [eax],al
000034FE  0000              add [eax],al
00003500  0000              add [eax],al
00003502  0000              add [eax],al
00003504  0000              add [eax],al
00003506  0000              add [eax],al
00003508  0000              add [eax],al
0000350A  0000              add [eax],al
0000350C  0000              add [eax],al
0000350E  0000              add [eax],al
00003510  0000              add [eax],al
00003512  0000              add [eax],al
00003514  0000              add [eax],al
00003516  0000              add [eax],al
00003518  0000              add [eax],al
0000351A  0000              add [eax],al
0000351C  0000              add [eax],al
0000351E  0000              add [eax],al
00003520  0000              add [eax],al
00003522  0000              add [eax],al
00003524  0000              add [eax],al
00003526  0000              add [eax],al
00003528  0000              add [eax],al
0000352A  0000              add [eax],al
0000352C  0000              add [eax],al
0000352E  0000              add [eax],al
00003530  0000              add [eax],al
00003532  0000              add [eax],al
00003534  0000              add [eax],al
00003536  0000              add [eax],al
00003538  0000              add [eax],al
0000353A  0000              add [eax],al
0000353C  0000              add [eax],al
0000353E  0000              add [eax],al
00003540  0000              add [eax],al
00003542  0000              add [eax],al
00003544  0000              add [eax],al
00003546  0000              add [eax],al
00003548  0000              add [eax],al
0000354A  0000              add [eax],al
0000354C  0000              add [eax],al
0000354E  0000              add [eax],al
00003550  0000              add [eax],al
00003552  0000              add [eax],al
00003554  0000              add [eax],al
00003556  0000              add [eax],al
00003558  0000              add [eax],al
0000355A  0000              add [eax],al
0000355C  0000              add [eax],al
0000355E  0000              add [eax],al
00003560  0000              add [eax],al
00003562  0000              add [eax],al
00003564  0000              add [eax],al
00003566  0000              add [eax],al
00003568  0000              add [eax],al
0000356A  0000              add [eax],al
0000356C  0000              add [eax],al
0000356E  0000              add [eax],al
00003570  0000              add [eax],al
00003572  0000              add [eax],al
00003574  0000              add [eax],al
00003576  0000              add [eax],al
00003578  0000              add [eax],al
0000357A  0000              add [eax],al
0000357C  0000              add [eax],al
0000357E  0000              add [eax],al
00003580  0000              add [eax],al
00003582  0000              add [eax],al
00003584  0000              add [eax],al
00003586  0000              add [eax],al
00003588  0000              add [eax],al
0000358A  0000              add [eax],al
0000358C  0000              add [eax],al
0000358E  0000              add [eax],al
00003590  0000              add [eax],al
00003592  0000              add [eax],al
00003594  0000              add [eax],al
00003596  0000              add [eax],al
00003598  0000              add [eax],al
0000359A  0000              add [eax],al
0000359C  0000              add [eax],al
0000359E  0000              add [eax],al
000035A0  0000              add [eax],al
000035A2  0000              add [eax],al
000035A4  0000              add [eax],al
000035A6  0000              add [eax],al
000035A8  0000              add [eax],al
000035AA  0000              add [eax],al
000035AC  0000              add [eax],al
000035AE  0000              add [eax],al
000035B0  0000              add [eax],al
000035B2  0000              add [eax],al
000035B4  0000              add [eax],al
000035B6  0000              add [eax],al
000035B8  0000              add [eax],al
000035BA  0000              add [eax],al
000035BC  0000              add [eax],al
000035BE  0000              add [eax],al
000035C0  0000              add [eax],al
000035C2  0000              add [eax],al
000035C4  0000              add [eax],al
000035C6  0000              add [eax],al
000035C8  0000              add [eax],al
000035CA  0000              add [eax],al
000035CC  0000              add [eax],al
000035CE  0000              add [eax],al
000035D0  0000              add [eax],al
000035D2  0000              add [eax],al
000035D4  0000              add [eax],al
000035D6  0000              add [eax],al
000035D8  0000              add [eax],al
000035DA  0000              add [eax],al
000035DC  0000              add [eax],al
000035DE  0000              add [eax],al
000035E0  0000              add [eax],al
000035E2  0000              add [eax],al
000035E4  0000              add [eax],al
000035E6  0000              add [eax],al
000035E8  0000              add [eax],al
000035EA  0000              add [eax],al
000035EC  0000              add [eax],al
000035EE  0000              add [eax],al
000035F0  0000              add [eax],al
000035F2  0000              add [eax],al
000035F4  0000              add [eax],al
000035F6  0000              add [eax],al
000035F8  0000              add [eax],al
000035FA  0000              add [eax],al
000035FC  0000              add [eax],al
000035FE  0000              add [eax],al
00003600  0000              add [eax],al
00003602  0000              add [eax],al
00003604  0000              add [eax],al
00003606  0000              add [eax],al
00003608  0000              add [eax],al
0000360A  0000              add [eax],al
0000360C  0000              add [eax],al
0000360E  0000              add [eax],al
00003610  0000              add [eax],al
00003612  0000              add [eax],al
00003614  0000              add [eax],al
00003616  0000              add [eax],al
00003618  0000              add [eax],al
0000361A  0000              add [eax],al
0000361C  0000              add [eax],al
0000361E  0000              add [eax],al
00003620  0000              add [eax],al
00003622  0000              add [eax],al
00003624  0000              add [eax],al
00003626  0000              add [eax],al
00003628  0000              add [eax],al
0000362A  0000              add [eax],al
0000362C  0000              add [eax],al
0000362E  0000              add [eax],al
00003630  0000              add [eax],al
00003632  0000              add [eax],al
00003634  0000              add [eax],al
00003636  0000              add [eax],al
00003638  0000              add [eax],al
0000363A  0000              add [eax],al
0000363C  0000              add [eax],al
0000363E  0000              add [eax],al
00003640  0000              add [eax],al
00003642  0000              add [eax],al
00003644  0000              add [eax],al
00003646  0000              add [eax],al
00003648  0000              add [eax],al
0000364A  0000              add [eax],al
0000364C  0000              add [eax],al
0000364E  0000              add [eax],al
00003650  0000              add [eax],al
00003652  0000              add [eax],al
00003654  0000              add [eax],al
00003656  0000              add [eax],al
00003658  0000              add [eax],al
0000365A  0000              add [eax],al
0000365C  0000              add [eax],al
0000365E  0000              add [eax],al
00003660  0000              add [eax],al
00003662  0000              add [eax],al
00003664  0000              add [eax],al
00003666  0000              add [eax],al
00003668  0000              add [eax],al
0000366A  0000              add [eax],al
0000366C  0000              add [eax],al
0000366E  0000              add [eax],al
00003670  0000              add [eax],al
00003672  0000              add [eax],al
00003674  0000              add [eax],al
00003676  0000              add [eax],al
00003678  0000              add [eax],al
0000367A  0000              add [eax],al
0000367C  0000              add [eax],al
0000367E  0000              add [eax],al
00003680  0000              add [eax],al
00003682  0000              add [eax],al
00003684  0000              add [eax],al
00003686  0000              add [eax],al
00003688  0000              add [eax],al
0000368A  0000              add [eax],al
0000368C  0000              add [eax],al
0000368E  0000              add [eax],al
00003690  0000              add [eax],al
00003692  0000              add [eax],al
00003694  0000              add [eax],al
00003696  0000              add [eax],al
00003698  0000              add [eax],al
0000369A  0000              add [eax],al
0000369C  0000              add [eax],al
0000369E  0000              add [eax],al
000036A0  0000              add [eax],al
000036A2  0000              add [eax],al
000036A4  0000              add [eax],al
000036A6  0000              add [eax],al
000036A8  0000              add [eax],al
000036AA  0000              add [eax],al
000036AC  0000              add [eax],al
000036AE  0000              add [eax],al
000036B0  0000              add [eax],al
000036B2  0000              add [eax],al
000036B4  0000              add [eax],al
000036B6  0000              add [eax],al
000036B8  0000              add [eax],al
000036BA  0000              add [eax],al
000036BC  0000              add [eax],al
000036BE  0000              add [eax],al
000036C0  0000              add [eax],al
000036C2  0000              add [eax],al
000036C4  0000              add [eax],al
000036C6  0000              add [eax],al
000036C8  0000              add [eax],al
000036CA  0000              add [eax],al
000036CC  0000              add [eax],al
000036CE  0000              add [eax],al
000036D0  0000              add [eax],al
000036D2  0000              add [eax],al
000036D4  0000              add [eax],al
000036D6  0000              add [eax],al
000036D8  0000              add [eax],al
000036DA  0000              add [eax],al
000036DC  0000              add [eax],al
000036DE  0000              add [eax],al
000036E0  0000              add [eax],al
000036E2  0000              add [eax],al
000036E4  0000              add [eax],al
000036E6  0000              add [eax],al
000036E8  0000              add [eax],al
000036EA  0000              add [eax],al
000036EC  0000              add [eax],al
000036EE  0000              add [eax],al
000036F0  0000              add [eax],al
000036F2  0000              add [eax],al
000036F4  0000              add [eax],al
000036F6  0000              add [eax],al
000036F8  0000              add [eax],al
000036FA  0000              add [eax],al
000036FC  0000              add [eax],al
000036FE  0000              add [eax],al
00003700  0000              add [eax],al
00003702  0000              add [eax],al
00003704  0000              add [eax],al
00003706  0000              add [eax],al
00003708  0000              add [eax],al
0000370A  0000              add [eax],al
0000370C  0000              add [eax],al
0000370E  0000              add [eax],al
00003710  0000              add [eax],al
00003712  0000              add [eax],al
00003714  0000              add [eax],al
00003716  0000              add [eax],al
00003718  0000              add [eax],al
0000371A  0000              add [eax],al
0000371C  0000              add [eax],al
0000371E  0000              add [eax],al
00003720  0000              add [eax],al
00003722  0000              add [eax],al
00003724  0000              add [eax],al
00003726  0000              add [eax],al
00003728  0000              add [eax],al
0000372A  0000              add [eax],al
0000372C  0000              add [eax],al
0000372E  0000              add [eax],al
00003730  0000              add [eax],al
00003732  0000              add [eax],al
00003734  0000              add [eax],al
00003736  0000              add [eax],al
00003738  0000              add [eax],al
0000373A  0000              add [eax],al
0000373C  0000              add [eax],al
0000373E  0000              add [eax],al
00003740  0000              add [eax],al
00003742  0000              add [eax],al
00003744  0000              add [eax],al
00003746  0000              add [eax],al
00003748  0000              add [eax],al
0000374A  0000              add [eax],al
0000374C  0000              add [eax],al
0000374E  0000              add [eax],al
00003750  0000              add [eax],al
00003752  0000              add [eax],al
00003754  0000              add [eax],al
00003756  0000              add [eax],al
00003758  0000              add [eax],al
0000375A  0000              add [eax],al
0000375C  0000              add [eax],al
0000375E  0000              add [eax],al
00003760  0000              add [eax],al
00003762  0000              add [eax],al
00003764  0000              add [eax],al
00003766  0000              add [eax],al
00003768  0000              add [eax],al
0000376A  0000              add [eax],al
0000376C  0000              add [eax],al
0000376E  0000              add [eax],al
00003770  0000              add [eax],al
00003772  0000              add [eax],al
00003774  0000              add [eax],al
00003776  0000              add [eax],al
00003778  0000              add [eax],al
0000377A  0000              add [eax],al
0000377C  0000              add [eax],al
0000377E  0000              add [eax],al
00003780  0000              add [eax],al
00003782  0000              add [eax],al
00003784  0000              add [eax],al
00003786  0000              add [eax],al
00003788  0000              add [eax],al
0000378A  0000              add [eax],al
0000378C  0000              add [eax],al
0000378E  0000              add [eax],al
00003790  0000              add [eax],al
00003792  0000              add [eax],al
00003794  0000              add [eax],al
00003796  0000              add [eax],al
00003798  0000              add [eax],al
0000379A  0000              add [eax],al
0000379C  0000              add [eax],al
0000379E  0000              add [eax],al
000037A0  0000              add [eax],al
000037A2  0000              add [eax],al
000037A4  0000              add [eax],al
000037A6  0000              add [eax],al
000037A8  0000              add [eax],al
000037AA  0000              add [eax],al
000037AC  0000              add [eax],al
000037AE  0000              add [eax],al
000037B0  0000              add [eax],al
000037B2  0000              add [eax],al
000037B4  0000              add [eax],al
000037B6  0000              add [eax],al
000037B8  0000              add [eax],al
000037BA  0000              add [eax],al
000037BC  0000              add [eax],al
000037BE  0000              add [eax],al
000037C0  0000              add [eax],al
000037C2  0000              add [eax],al
000037C4  0000              add [eax],al
000037C6  0000              add [eax],al
000037C8  0000              add [eax],al
000037CA  0000              add [eax],al
000037CC  0000              add [eax],al
000037CE  0000              add [eax],al
000037D0  0000              add [eax],al
000037D2  0000              add [eax],al
000037D4  0000              add [eax],al
000037D6  0000              add [eax],al
000037D8  0000              add [eax],al
000037DA  0000              add [eax],al
000037DC  0000              add [eax],al
000037DE  0000              add [eax],al
000037E0  0000              add [eax],al
000037E2  0000              add [eax],al
000037E4  0000              add [eax],al
000037E6  0000              add [eax],al
000037E8  0000              add [eax],al
000037EA  0000              add [eax],al
000037EC  0000              add [eax],al
000037EE  0000              add [eax],al
000037F0  0000              add [eax],al
000037F2  0000              add [eax],al
000037F4  0000              add [eax],al
000037F6  0000              add [eax],al
000037F8  0000              add [eax],al
000037FA  0000              add [eax],al
000037FC  0000              add [eax],al
000037FE  0000              add [eax],al
00003800  0000              add [eax],al
00003802  0000              add [eax],al
00003804  0000              add [eax],al
00003806  0000              add [eax],al
00003808  0000              add [eax],al
0000380A  0000              add [eax],al
0000380C  0000              add [eax],al
0000380E  0000              add [eax],al
00003810  0000              add [eax],al
00003812  0000              add [eax],al
00003814  0000              add [eax],al
00003816  0000              add [eax],al
00003818  0000              add [eax],al
0000381A  0000              add [eax],al
0000381C  0000              add [eax],al
0000381E  0000              add [eax],al
00003820  0000              add [eax],al
00003822  0000              add [eax],al
00003824  0000              add [eax],al
00003826  0000              add [eax],al
00003828  0000              add [eax],al
0000382A  0000              add [eax],al
0000382C  0000              add [eax],al
0000382E  0000              add [eax],al
00003830  0000              add [eax],al
00003832  0000              add [eax],al
00003834  0000              add [eax],al
00003836  0000              add [eax],al
00003838  0000              add [eax],al
0000383A  0000              add [eax],al
0000383C  0000              add [eax],al
0000383E  0000              add [eax],al
00003840  0000              add [eax],al
00003842  0000              add [eax],al
00003844  0000              add [eax],al
00003846  0000              add [eax],al
00003848  0000              add [eax],al
0000384A  0000              add [eax],al
0000384C  0000              add [eax],al
0000384E  0000              add [eax],al
00003850  0000              add [eax],al
00003852  0000              add [eax],al
00003854  0000              add [eax],al
00003856  0000              add [eax],al
00003858  0000              add [eax],al
0000385A  0000              add [eax],al
0000385C  0000              add [eax],al
0000385E  0000              add [eax],al
00003860  0000              add [eax],al
00003862  0000              add [eax],al
00003864  0000              add [eax],al
00003866  0000              add [eax],al
00003868  0000              add [eax],al
0000386A  0000              add [eax],al
0000386C  0000              add [eax],al
0000386E  0000              add [eax],al
00003870  0000              add [eax],al
00003872  0000              add [eax],al
00003874  0000              add [eax],al
00003876  0000              add [eax],al
00003878  0000              add [eax],al
0000387A  0000              add [eax],al
0000387C  0000              add [eax],al
0000387E  0000              add [eax],al
00003880  0000              add [eax],al
00003882  0000              add [eax],al
00003884  0000              add [eax],al
00003886  0000              add [eax],al
00003888  0000              add [eax],al
0000388A  0000              add [eax],al
0000388C  0000              add [eax],al
0000388E  0000              add [eax],al
00003890  0000              add [eax],al
00003892  0000              add [eax],al
00003894  0000              add [eax],al
00003896  0000              add [eax],al
00003898  0000              add [eax],al
0000389A  0000              add [eax],al
0000389C  0000              add [eax],al
0000389E  0000              add [eax],al
000038A0  0000              add [eax],al
000038A2  0000              add [eax],al
000038A4  0000              add [eax],al
000038A6  0000              add [eax],al
000038A8  0000              add [eax],al
000038AA  0000              add [eax],al
000038AC  0000              add [eax],al
000038AE  0000              add [eax],al
000038B0  0000              add [eax],al
000038B2  0000              add [eax],al
000038B4  0000              add [eax],al
000038B6  0000              add [eax],al
000038B8  0000              add [eax],al
000038BA  0000              add [eax],al
000038BC  0000              add [eax],al
000038BE  0000              add [eax],al
000038C0  0000              add [eax],al
000038C2  0000              add [eax],al
000038C4  0000              add [eax],al
000038C6  0000              add [eax],al
000038C8  0000              add [eax],al
000038CA  0000              add [eax],al
000038CC  0000              add [eax],al
000038CE  0000              add [eax],al
000038D0  0000              add [eax],al
000038D2  0000              add [eax],al
000038D4  0000              add [eax],al
000038D6  0000              add [eax],al
000038D8  0000              add [eax],al
000038DA  0000              add [eax],al
000038DC  0000              add [eax],al
000038DE  0000              add [eax],al
000038E0  0000              add [eax],al
000038E2  0000              add [eax],al
000038E4  0000              add [eax],al
000038E6  0000              add [eax],al
000038E8  0000              add [eax],al
000038EA  0000              add [eax],al
000038EC  0000              add [eax],al
000038EE  0000              add [eax],al
000038F0  0000              add [eax],al
000038F2  0000              add [eax],al
000038F4  0000              add [eax],al
000038F6  0000              add [eax],al
000038F8  0000              add [eax],al
000038FA  0000              add [eax],al
000038FC  0000              add [eax],al
000038FE  0000              add [eax],al
00003900  0000              add [eax],al
00003902  0000              add [eax],al
00003904  0000              add [eax],al
00003906  0000              add [eax],al
00003908  0000              add [eax],al
0000390A  0000              add [eax],al
0000390C  0000              add [eax],al
0000390E  0000              add [eax],al
00003910  0000              add [eax],al
00003912  0000              add [eax],al
00003914  0000              add [eax],al
00003916  0000              add [eax],al
00003918  0000              add [eax],al
0000391A  0000              add [eax],al
0000391C  0000              add [eax],al
0000391E  0000              add [eax],al
00003920  0000              add [eax],al
00003922  0000              add [eax],al
00003924  0000              add [eax],al
00003926  0000              add [eax],al
00003928  0000              add [eax],al
0000392A  0000              add [eax],al
0000392C  0000              add [eax],al
0000392E  0000              add [eax],al
00003930  0000              add [eax],al
00003932  0000              add [eax],al
00003934  0000              add [eax],al
00003936  0000              add [eax],al
00003938  0000              add [eax],al
0000393A  0000              add [eax],al
0000393C  0000              add [eax],al
0000393E  0000              add [eax],al
00003940  0000              add [eax],al
00003942  0000              add [eax],al
00003944  0000              add [eax],al
00003946  0000              add [eax],al
00003948  0000              add [eax],al
0000394A  0000              add [eax],al
0000394C  0000              add [eax],al
0000394E  0000              add [eax],al
00003950  0000              add [eax],al
00003952  0000              add [eax],al
00003954  0000              add [eax],al
00003956  0000              add [eax],al
00003958  0000              add [eax],al
0000395A  0000              add [eax],al
0000395C  0000              add [eax],al
0000395E  0000              add [eax],al
00003960  0000              add [eax],al
00003962  0000              add [eax],al
00003964  0000              add [eax],al
00003966  0000              add [eax],al
00003968  0000              add [eax],al
0000396A  0000              add [eax],al
0000396C  0000              add [eax],al
0000396E  0000              add [eax],al
00003970  0000              add [eax],al
00003972  0000              add [eax],al
00003974  0000              add [eax],al
00003976  0000              add [eax],al
00003978  0000              add [eax],al
0000397A  0000              add [eax],al
0000397C  0000              add [eax],al
0000397E  0000              add [eax],al
00003980  0000              add [eax],al
00003982  0000              add [eax],al
00003984  0000              add [eax],al
00003986  0000              add [eax],al
00003988  0000              add [eax],al
0000398A  0000              add [eax],al
0000398C  0000              add [eax],al
0000398E  0000              add [eax],al
00003990  0000              add [eax],al
00003992  0000              add [eax],al
00003994  0000              add [eax],al
00003996  0000              add [eax],al
00003998  0000              add [eax],al
0000399A  0000              add [eax],al
0000399C  0000              add [eax],al
0000399E  0000              add [eax],al
000039A0  0000              add [eax],al
000039A2  0000              add [eax],al
000039A4  0000              add [eax],al
000039A6  0000              add [eax],al
000039A8  0000              add [eax],al
000039AA  0000              add [eax],al
000039AC  0000              add [eax],al
000039AE  0000              add [eax],al
000039B0  0000              add [eax],al
000039B2  0000              add [eax],al
000039B4  0000              add [eax],al
000039B6  0000              add [eax],al
000039B8  0000              add [eax],al
000039BA  0000              add [eax],al
000039BC  0000              add [eax],al
000039BE  0000              add [eax],al
000039C0  0000              add [eax],al
000039C2  0000              add [eax],al
000039C4  0000              add [eax],al
000039C6  0000              add [eax],al
000039C8  0000              add [eax],al
000039CA  0000              add [eax],al
000039CC  0000              add [eax],al
000039CE  0000              add [eax],al
000039D0  0000              add [eax],al
000039D2  0000              add [eax],al
000039D4  0000              add [eax],al
000039D6  0000              add [eax],al
000039D8  0000              add [eax],al
000039DA  0000              add [eax],al
000039DC  0000              add [eax],al
000039DE  0000              add [eax],al
000039E0  0000              add [eax],al
000039E2  0000              add [eax],al
000039E4  0000              add [eax],al
000039E6  0000              add [eax],al
000039E8  0000              add [eax],al
000039EA  0000              add [eax],al
000039EC  0000              add [eax],al
000039EE  0000              add [eax],al
000039F0  0000              add [eax],al
000039F2  0000              add [eax],al
000039F4  0000              add [eax],al
000039F6  0000              add [eax],al
000039F8  0000              add [eax],al
000039FA  0000              add [eax],al
000039FC  0000              add [eax],al
000039FE  0000              add [eax],al
00003A00  0000              add [eax],al
00003A02  0000              add [eax],al
00003A04  0000              add [eax],al
00003A06  0000              add [eax],al
00003A08  0000              add [eax],al
00003A0A  0000              add [eax],al
00003A0C  0000              add [eax],al
00003A0E  0000              add [eax],al
00003A10  0000              add [eax],al
00003A12  0000              add [eax],al
00003A14  0000              add [eax],al
00003A16  0000              add [eax],al
00003A18  0000              add [eax],al
00003A1A  0000              add [eax],al
00003A1C  0000              add [eax],al
00003A1E  0000              add [eax],al
00003A20  0000              add [eax],al
00003A22  0000              add [eax],al
00003A24  0000              add [eax],al
00003A26  0000              add [eax],al
00003A28  0000              add [eax],al
00003A2A  0000              add [eax],al
00003A2C  0000              add [eax],al
00003A2E  0000              add [eax],al
00003A30  0000              add [eax],al
00003A32  0000              add [eax],al
00003A34  0000              add [eax],al
00003A36  0000              add [eax],al
00003A38  0000              add [eax],al
00003A3A  0000              add [eax],al
00003A3C  0000              add [eax],al
00003A3E  0000              add [eax],al
00003A40  0000              add [eax],al
00003A42  0000              add [eax],al
00003A44  0000              add [eax],al
00003A46  0000              add [eax],al
00003A48  0000              add [eax],al
00003A4A  0000              add [eax],al
00003A4C  0000              add [eax],al
00003A4E  0000              add [eax],al
00003A50  0000              add [eax],al
00003A52  0000              add [eax],al
00003A54  0000              add [eax],al
00003A56  0000              add [eax],al
00003A58  0000              add [eax],al
00003A5A  0000              add [eax],al
00003A5C  0000              add [eax],al
00003A5E  0000              add [eax],al
00003A60  0000              add [eax],al
00003A62  0000              add [eax],al
00003A64  0000              add [eax],al
00003A66  0000              add [eax],al
00003A68  0000              add [eax],al
00003A6A  0000              add [eax],al
00003A6C  0000              add [eax],al
00003A6E  0000              add [eax],al
00003A70  0000              add [eax],al
00003A72  0000              add [eax],al
00003A74  0000              add [eax],al
00003A76  0000              add [eax],al
00003A78  0000              add [eax],al
00003A7A  0000              add [eax],al
00003A7C  0000              add [eax],al
00003A7E  0000              add [eax],al
00003A80  0000              add [eax],al
00003A82  0000              add [eax],al
00003A84  0000              add [eax],al
00003A86  0000              add [eax],al
00003A88  0000              add [eax],al
00003A8A  0000              add [eax],al
00003A8C  0000              add [eax],al
00003A8E  0000              add [eax],al
00003A90  0000              add [eax],al
00003A92  0000              add [eax],al
00003A94  0000              add [eax],al
00003A96  0000              add [eax],al
00003A98  0000              add [eax],al
00003A9A  0000              add [eax],al
00003A9C  0000              add [eax],al
00003A9E  0000              add [eax],al
00003AA0  0000              add [eax],al
00003AA2  0000              add [eax],al
00003AA4  0000              add [eax],al
00003AA6  0000              add [eax],al
00003AA8  0000              add [eax],al
00003AAA  0000              add [eax],al
00003AAC  0000              add [eax],al
00003AAE  0000              add [eax],al
00003AB0  0000              add [eax],al
00003AB2  0000              add [eax],al
00003AB4  0000              add [eax],al
00003AB6  0000              add [eax],al
00003AB8  0000              add [eax],al
00003ABA  0000              add [eax],al
00003ABC  0000              add [eax],al
00003ABE  0000              add [eax],al
00003AC0  0000              add [eax],al
00003AC2  0000              add [eax],al
00003AC4  0000              add [eax],al
00003AC6  0000              add [eax],al
00003AC8  0000              add [eax],al
00003ACA  0000              add [eax],al
00003ACC  0000              add [eax],al
00003ACE  0000              add [eax],al
00003AD0  0000              add [eax],al
00003AD2  0000              add [eax],al
00003AD4  0000              add [eax],al
00003AD6  0000              add [eax],al
00003AD8  0000              add [eax],al
00003ADA  0000              add [eax],al
00003ADC  0000              add [eax],al
00003ADE  0000              add [eax],al
00003AE0  0000              add [eax],al
00003AE2  0000              add [eax],al
00003AE4  0000              add [eax],al
00003AE6  0000              add [eax],al
00003AE8  0000              add [eax],al
00003AEA  0000              add [eax],al
00003AEC  0000              add [eax],al
00003AEE  0000              add [eax],al
00003AF0  0000              add [eax],al
00003AF2  0000              add [eax],al
00003AF4  0000              add [eax],al
00003AF6  0000              add [eax],al
00003AF8  0000              add [eax],al
00003AFA  0000              add [eax],al
00003AFC  0000              add [eax],al
00003AFE  0000              add [eax],al
00003B00  0000              add [eax],al
00003B02  0000              add [eax],al
00003B04  0000              add [eax],al
00003B06  0000              add [eax],al
00003B08  0000              add [eax],al
00003B0A  0000              add [eax],al
00003B0C  0000              add [eax],al
00003B0E  0000              add [eax],al
00003B10  0000              add [eax],al
00003B12  0000              add [eax],al
00003B14  0000              add [eax],al
00003B16  0000              add [eax],al
00003B18  0000              add [eax],al
00003B1A  0000              add [eax],al
00003B1C  0000              add [eax],al
00003B1E  0000              add [eax],al
00003B20  0000              add [eax],al
00003B22  0000              add [eax],al
00003B24  0000              add [eax],al
00003B26  0000              add [eax],al
00003B28  0000              add [eax],al
00003B2A  0000              add [eax],al
00003B2C  0000              add [eax],al
00003B2E  0000              add [eax],al
00003B30  0000              add [eax],al
00003B32  0000              add [eax],al
00003B34  0000              add [eax],al
00003B36  0000              add [eax],al
00003B38  0000              add [eax],al
00003B3A  0000              add [eax],al
00003B3C  0000              add [eax],al
00003B3E  0000              add [eax],al
00003B40  0000              add [eax],al
00003B42  0000              add [eax],al
00003B44  0000              add [eax],al
00003B46  0000              add [eax],al
00003B48  0000              add [eax],al
00003B4A  0000              add [eax],al
00003B4C  0000              add [eax],al
00003B4E  0000              add [eax],al
00003B50  0000              add [eax],al
00003B52  0000              add [eax],al
00003B54  0000              add [eax],al
00003B56  0000              add [eax],al
00003B58  0000              add [eax],al
00003B5A  0000              add [eax],al
00003B5C  0000              add [eax],al
00003B5E  0000              add [eax],al
00003B60  0000              add [eax],al
00003B62  0000              add [eax],al
00003B64  0000              add [eax],al
00003B66  0000              add [eax],al
00003B68  0000              add [eax],al
00003B6A  0000              add [eax],al
00003B6C  0000              add [eax],al
00003B6E  0000              add [eax],al
00003B70  0000              add [eax],al
00003B72  0000              add [eax],al
00003B74  0000              add [eax],al
00003B76  0000              add [eax],al
00003B78  0000              add [eax],al
00003B7A  0000              add [eax],al
00003B7C  0000              add [eax],al
00003B7E  0000              add [eax],al
00003B80  0000              add [eax],al
00003B82  0000              add [eax],al
00003B84  0000              add [eax],al
00003B86  0000              add [eax],al
00003B88  0000              add [eax],al
00003B8A  0000              add [eax],al
00003B8C  0000              add [eax],al
00003B8E  0000              add [eax],al
00003B90  0000              add [eax],al
00003B92  0000              add [eax],al
00003B94  0000              add [eax],al
00003B96  0000              add [eax],al
00003B98  0000              add [eax],al
00003B9A  0000              add [eax],al
00003B9C  0000              add [eax],al
00003B9E  0000              add [eax],al
00003BA0  0000              add [eax],al
00003BA2  0000              add [eax],al
00003BA4  0000              add [eax],al
00003BA6  0000              add [eax],al
00003BA8  0000              add [eax],al
00003BAA  0000              add [eax],al
00003BAC  0000              add [eax],al
00003BAE  0000              add [eax],al
00003BB0  0000              add [eax],al
00003BB2  0000              add [eax],al
00003BB4  0000              add [eax],al
00003BB6  0000              add [eax],al
00003BB8  0000              add [eax],al
00003BBA  0000              add [eax],al
00003BBC  0000              add [eax],al
00003BBE  0000              add [eax],al
00003BC0  0000              add [eax],al
00003BC2  0000              add [eax],al
00003BC4  0000              add [eax],al
00003BC6  0000              add [eax],al
00003BC8  0000              add [eax],al
00003BCA  0000              add [eax],al
00003BCC  0000              add [eax],al
00003BCE  0000              add [eax],al
00003BD0  0000              add [eax],al
00003BD2  0000              add [eax],al
00003BD4  0000              add [eax],al
00003BD6  0000              add [eax],al
00003BD8  0000              add [eax],al
00003BDA  0000              add [eax],al
00003BDC  0000              add [eax],al
00003BDE  0000              add [eax],al
00003BE0  0000              add [eax],al
00003BE2  0000              add [eax],al
00003BE4  0000              add [eax],al
00003BE6  0000              add [eax],al
00003BE8  0000              add [eax],al
00003BEA  0000              add [eax],al
00003BEC  0000              add [eax],al
00003BEE  0000              add [eax],al
00003BF0  0000              add [eax],al
00003BF2  0000              add [eax],al
00003BF4  0000              add [eax],al
00003BF6  0000              add [eax],al
00003BF8  0000              add [eax],al
00003BFA  0000              add [eax],al
00003BFC  0000              add [eax],al
00003BFE  0000              add [eax],al
00003C00  0000              add [eax],al
00003C02  0000              add [eax],al
00003C04  0000              add [eax],al
00003C06  0000              add [eax],al
00003C08  0000              add [eax],al
00003C0A  0000              add [eax],al
00003C0C  0000              add [eax],al
00003C0E  0000              add [eax],al
00003C10  0000              add [eax],al
00003C12  0000              add [eax],al
00003C14  0000              add [eax],al
00003C16  0000              add [eax],al
00003C18  0000              add [eax],al
00003C1A  0000              add [eax],al
00003C1C  0000              add [eax],al
00003C1E  0000              add [eax],al
00003C20  0000              add [eax],al
00003C22  0000              add [eax],al
00003C24  0000              add [eax],al
00003C26  0000              add [eax],al
00003C28  0000              add [eax],al
00003C2A  0000              add [eax],al
00003C2C  0000              add [eax],al
00003C2E  0000              add [eax],al
00003C30  0000              add [eax],al
00003C32  0000              add [eax],al
00003C34  0000              add [eax],al
00003C36  0000              add [eax],al
00003C38  0000              add [eax],al
00003C3A  0000              add [eax],al
00003C3C  0000              add [eax],al
00003C3E  0000              add [eax],al
00003C40  0000              add [eax],al
00003C42  0000              add [eax],al
00003C44  0000              add [eax],al
00003C46  0000              add [eax],al
00003C48  0000              add [eax],al
00003C4A  0000              add [eax],al
00003C4C  0000              add [eax],al
00003C4E  0000              add [eax],al
00003C50  0000              add [eax],al
00003C52  0000              add [eax],al
00003C54  0000              add [eax],al
00003C56  0000              add [eax],al
00003C58  0000              add [eax],al
00003C5A  0000              add [eax],al
00003C5C  0000              add [eax],al
00003C5E  0000              add [eax],al
00003C60  0000              add [eax],al
00003C62  0000              add [eax],al
00003C64  0000              add [eax],al
00003C66  0000              add [eax],al
00003C68  0000              add [eax],al
00003C6A  0000              add [eax],al
00003C6C  0000              add [eax],al
00003C6E  0000              add [eax],al
00003C70  0000              add [eax],al
00003C72  0000              add [eax],al
00003C74  0000              add [eax],al
00003C76  0000              add [eax],al
00003C78  0000              add [eax],al
00003C7A  0000              add [eax],al
00003C7C  0000              add [eax],al
00003C7E  0000              add [eax],al
00003C80  0000              add [eax],al
00003C82  0000              add [eax],al
00003C84  0000              add [eax],al
00003C86  0000              add [eax],al
00003C88  0000              add [eax],al
00003C8A  0000              add [eax],al
00003C8C  0000              add [eax],al
00003C8E  0000              add [eax],al
00003C90  0000              add [eax],al
00003C92  0000              add [eax],al
00003C94  0000              add [eax],al
00003C96  0000              add [eax],al
00003C98  0000              add [eax],al
00003C9A  0000              add [eax],al
00003C9C  0000              add [eax],al
00003C9E  0000              add [eax],al
00003CA0  0000              add [eax],al
00003CA2  0000              add [eax],al
00003CA4  0000              add [eax],al
00003CA6  0000              add [eax],al
00003CA8  0000              add [eax],al
00003CAA  0000              add [eax],al
00003CAC  0000              add [eax],al
00003CAE  0000              add [eax],al
00003CB0  0000              add [eax],al
00003CB2  0000              add [eax],al
00003CB4  0000              add [eax],al
00003CB6  0000              add [eax],al
00003CB8  0000              add [eax],al
00003CBA  0000              add [eax],al
00003CBC  0000              add [eax],al
00003CBE  0000              add [eax],al
00003CC0  0000              add [eax],al
00003CC2  0000              add [eax],al
00003CC4  0000              add [eax],al
00003CC6  0000              add [eax],al
00003CC8  0000              add [eax],al
00003CCA  0000              add [eax],al
00003CCC  0000              add [eax],al
00003CCE  0000              add [eax],al
00003CD0  0000              add [eax],al
00003CD2  0000              add [eax],al
00003CD4  0000              add [eax],al
00003CD6  0000              add [eax],al
00003CD8  0000              add [eax],al
00003CDA  0000              add [eax],al
00003CDC  0000              add [eax],al
00003CDE  0000              add [eax],al
00003CE0  0000              add [eax],al
00003CE2  0000              add [eax],al
00003CE4  0000              add [eax],al
00003CE6  0000              add [eax],al
00003CE8  0000              add [eax],al
00003CEA  0000              add [eax],al
00003CEC  0000              add [eax],al
00003CEE  0000              add [eax],al
00003CF0  0000              add [eax],al
00003CF2  0000              add [eax],al
00003CF4  0000              add [eax],al
00003CF6  0000              add [eax],al
00003CF8  0000              add [eax],al
00003CFA  0000              add [eax],al
00003CFC  0000              add [eax],al
00003CFE  0000              add [eax],al
00003D00  0000              add [eax],al
00003D02  0000              add [eax],al
00003D04  0000              add [eax],al
00003D06  0000              add [eax],al
00003D08  0000              add [eax],al
00003D0A  0000              add [eax],al
00003D0C  0000              add [eax],al
00003D0E  0000              add [eax],al
00003D10  0000              add [eax],al
00003D12  0000              add [eax],al
00003D14  0000              add [eax],al
00003D16  0000              add [eax],al
00003D18  0000              add [eax],al
00003D1A  0000              add [eax],al
00003D1C  0000              add [eax],al
00003D1E  0000              add [eax],al
00003D20  0000              add [eax],al
00003D22  0000              add [eax],al
00003D24  0000              add [eax],al
00003D26  0000              add [eax],al
00003D28  0000              add [eax],al
00003D2A  0000              add [eax],al
00003D2C  0000              add [eax],al
00003D2E  0000              add [eax],al
00003D30  0000              add [eax],al
00003D32  0000              add [eax],al
00003D34  0000              add [eax],al
00003D36  0000              add [eax],al
00003D38  0000              add [eax],al
00003D3A  0000              add [eax],al
00003D3C  0000              add [eax],al
00003D3E  0000              add [eax],al
00003D40  0000              add [eax],al
00003D42  0000              add [eax],al
00003D44  0000              add [eax],al
00003D46  0000              add [eax],al
00003D48  0000              add [eax],al
00003D4A  0000              add [eax],al
00003D4C  0000              add [eax],al
00003D4E  0000              add [eax],al
00003D50  0000              add [eax],al
00003D52  0000              add [eax],al
00003D54  0000              add [eax],al
00003D56  0000              add [eax],al
00003D58  0000              add [eax],al
00003D5A  0000              add [eax],al
00003D5C  0000              add [eax],al
00003D5E  0000              add [eax],al
00003D60  0000              add [eax],al
00003D62  0000              add [eax],al
00003D64  0000              add [eax],al
00003D66  0000              add [eax],al
00003D68  0000              add [eax],al
00003D6A  0000              add [eax],al
00003D6C  0000              add [eax],al
00003D6E  0000              add [eax],al
00003D70  0000              add [eax],al
00003D72  0000              add [eax],al
00003D74  0000              add [eax],al
00003D76  0000              add [eax],al
00003D78  0000              add [eax],al
00003D7A  0000              add [eax],al
00003D7C  0000              add [eax],al
00003D7E  0000              add [eax],al
00003D80  0000              add [eax],al
00003D82  0000              add [eax],al
00003D84  0000              add [eax],al
00003D86  0000              add [eax],al
00003D88  0000              add [eax],al
00003D8A  0000              add [eax],al
00003D8C  0000              add [eax],al
00003D8E  0000              add [eax],al
00003D90  0000              add [eax],al
00003D92  0000              add [eax],al
00003D94  0000              add [eax],al
00003D96  0000              add [eax],al
00003D98  0000              add [eax],al
00003D9A  0000              add [eax],al
00003D9C  0000              add [eax],al
00003D9E  0000              add [eax],al
00003DA0  0000              add [eax],al
00003DA2  0000              add [eax],al
00003DA4  0000              add [eax],al
00003DA6  0000              add [eax],al
00003DA8  0000              add [eax],al
00003DAA  0000              add [eax],al
00003DAC  0000              add [eax],al
00003DAE  0000              add [eax],al
00003DB0  0000              add [eax],al
00003DB2  0000              add [eax],al
00003DB4  0000              add [eax],al
00003DB6  0000              add [eax],al
00003DB8  0000              add [eax],al
00003DBA  0000              add [eax],al
00003DBC  0000              add [eax],al
00003DBE  0000              add [eax],al
00003DC0  0000              add [eax],al
00003DC2  0000              add [eax],al
00003DC4  0000              add [eax],al
00003DC6  0000              add [eax],al
00003DC8  0000              add [eax],al
00003DCA  0000              add [eax],al
00003DCC  0000              add [eax],al
00003DCE  0000              add [eax],al
00003DD0  0000              add [eax],al
00003DD2  0000              add [eax],al
00003DD4  0000              add [eax],al
00003DD6  0000              add [eax],al
00003DD8  0000              add [eax],al
00003DDA  0000              add [eax],al
00003DDC  0000              add [eax],al
00003DDE  0000              add [eax],al
00003DE0  0000              add [eax],al
00003DE2  0000              add [eax],al
00003DE4  0000              add [eax],al
00003DE6  0000              add [eax],al
00003DE8  0000              add [eax],al
00003DEA  0000              add [eax],al
00003DEC  0000              add [eax],al
00003DEE  0000              add [eax],al
00003DF0  0000              add [eax],al
00003DF2  0000              add [eax],al
00003DF4  0000              add [eax],al
00003DF6  0000              add [eax],al
00003DF8  0000              add [eax],al
00003DFA  0000              add [eax],al
00003DFC  0000              add [eax],al
00003DFE  0000              add [eax],al
00003E00  0000              add [eax],al
00003E02  0000              add [eax],al
00003E04  0000              add [eax],al
00003E06  0000              add [eax],al
00003E08  0000              add [eax],al
00003E0A  0000              add [eax],al
00003E0C  0000              add [eax],al
00003E0E  0000              add [eax],al
00003E10  0000              add [eax],al
00003E12  0000              add [eax],al
00003E14  0000              add [eax],al
00003E16  0000              add [eax],al
00003E18  0000              add [eax],al
00003E1A  0000              add [eax],al
00003E1C  0000              add [eax],al
00003E1E  0000              add [eax],al
00003E20  0000              add [eax],al
00003E22  0000              add [eax],al
00003E24  0000              add [eax],al
00003E26  0000              add [eax],al
00003E28  0000              add [eax],al
00003E2A  0000              add [eax],al
00003E2C  0000              add [eax],al
00003E2E  0000              add [eax],al
00003E30  0000              add [eax],al
00003E32  0000              add [eax],al
00003E34  0000              add [eax],al
00003E36  0000              add [eax],al
00003E38  0000              add [eax],al
00003E3A  0000              add [eax],al
00003E3C  0000              add [eax],al
00003E3E  0000              add [eax],al
00003E40  0000              add [eax],al
00003E42  0000              add [eax],al
00003E44  0000              add [eax],al
00003E46  0000              add [eax],al
00003E48  0000              add [eax],al
00003E4A  0000              add [eax],al
00003E4C  0000              add [eax],al
00003E4E  0000              add [eax],al
00003E50  0000              add [eax],al
00003E52  0000              add [eax],al
00003E54  0000              add [eax],al
00003E56  0000              add [eax],al
00003E58  0000              add [eax],al
00003E5A  0000              add [eax],al
00003E5C  0000              add [eax],al
00003E5E  0000              add [eax],al
00003E60  0000              add [eax],al
00003E62  0000              add [eax],al
00003E64  0000              add [eax],al
00003E66  0000              add [eax],al
00003E68  0000              add [eax],al
00003E6A  0000              add [eax],al
00003E6C  0000              add [eax],al
00003E6E  0000              add [eax],al
00003E70  0000              add [eax],al
00003E72  0000              add [eax],al
00003E74  0000              add [eax],al
00003E76  0000              add [eax],al
00003E78  0000              add [eax],al
00003E7A  0000              add [eax],al
00003E7C  0000              add [eax],al
00003E7E  0000              add [eax],al
00003E80  0000              add [eax],al
00003E82  0000              add [eax],al
00003E84  0000              add [eax],al
00003E86  0000              add [eax],al
00003E88  0000              add [eax],al
00003E8A  0000              add [eax],al
00003E8C  0000              add [eax],al
00003E8E  0000              add [eax],al
00003E90  0000              add [eax],al
00003E92  0000              add [eax],al
00003E94  0000              add [eax],al
00003E96  0000              add [eax],al
00003E98  0000              add [eax],al
00003E9A  0000              add [eax],al
00003E9C  0000              add [eax],al
00003E9E  0000              add [eax],al
00003EA0  0000              add [eax],al
00003EA2  0000              add [eax],al
00003EA4  0000              add [eax],al
00003EA6  0000              add [eax],al
00003EA8  0000              add [eax],al
00003EAA  0000              add [eax],al
00003EAC  0000              add [eax],al
00003EAE  0000              add [eax],al
00003EB0  0000              add [eax],al
00003EB2  0000              add [eax],al
00003EB4  0000              add [eax],al
00003EB6  0000              add [eax],al
00003EB8  0000              add [eax],al
00003EBA  0000              add [eax],al
00003EBC  0000              add [eax],al
00003EBE  0000              add [eax],al
00003EC0  0000              add [eax],al
00003EC2  0000              add [eax],al
00003EC4  0000              add [eax],al
00003EC6  0000              add [eax],al
00003EC8  0000              add [eax],al
00003ECA  0000              add [eax],al
00003ECC  0000              add [eax],al
00003ECE  0000              add [eax],al
00003ED0  0000              add [eax],al
00003ED2  0000              add [eax],al
00003ED4  0000              add [eax],al
00003ED6  0000              add [eax],al
00003ED8  0000              add [eax],al
00003EDA  0000              add [eax],al
00003EDC  0000              add [eax],al
00003EDE  0000              add [eax],al
00003EE0  0000              add [eax],al
00003EE2  0000              add [eax],al
00003EE4  0000              add [eax],al
00003EE6  0000              add [eax],al
00003EE8  0000              add [eax],al
00003EEA  0000              add [eax],al
00003EEC  0000              add [eax],al
00003EEE  0000              add [eax],al
00003EF0  0000              add [eax],al
00003EF2  0000              add [eax],al
00003EF4  0000              add [eax],al
00003EF6  0000              add [eax],al
00003EF8  0000              add [eax],al
00003EFA  0000              add [eax],al
00003EFC  0000              add [eax],al
00003EFE  0000              add [eax],al
00003F00  0000              add [eax],al
00003F02  0000              add [eax],al
00003F04  0000              add [eax],al
00003F06  0000              add [eax],al
00003F08  0000              add [eax],al
00003F0A  0000              add [eax],al
00003F0C  0000              add [eax],al
00003F0E  0000              add [eax],al
00003F10  0000              add [eax],al
00003F12  0000              add [eax],al
00003F14  0000              add [eax],al
00003F16  0000              add [eax],al
00003F18  0000              add [eax],al
00003F1A  0000              add [eax],al
00003F1C  0000              add [eax],al
00003F1E  0000              add [eax],al
00003F20  0000              add [eax],al
00003F22  0000              add [eax],al
00003F24  0000              add [eax],al
00003F26  0000              add [eax],al
00003F28  0000              add [eax],al
00003F2A  0000              add [eax],al
00003F2C  0000              add [eax],al
00003F2E  0000              add [eax],al
00003F30  0000              add [eax],al
00003F32  0000              add [eax],al
00003F34  0000              add [eax],al
00003F36  0000              add [eax],al
00003F38  0000              add [eax],al
00003F3A  0000              add [eax],al
00003F3C  0000              add [eax],al
00003F3E  0000              add [eax],al
00003F40  0000              add [eax],al
00003F42  0000              add [eax],al
00003F44  0000              add [eax],al
00003F46  0000              add [eax],al
00003F48  0000              add [eax],al
00003F4A  0000              add [eax],al
00003F4C  0000              add [eax],al
00003F4E  0000              add [eax],al
00003F50  0000              add [eax],al
00003F52  0000              add [eax],al
00003F54  0000              add [eax],al
00003F56  0000              add [eax],al
00003F58  0000              add [eax],al
00003F5A  0000              add [eax],al
00003F5C  0000              add [eax],al
00003F5E  0000              add [eax],al
00003F60  0000              add [eax],al
00003F62  0000              add [eax],al
00003F64  0000              add [eax],al
00003F66  0000              add [eax],al
00003F68  0000              add [eax],al
00003F6A  0000              add [eax],al
00003F6C  0000              add [eax],al
00003F6E  0000              add [eax],al
00003F70  0000              add [eax],al
00003F72  0000              add [eax],al
00003F74  0000              add [eax],al
00003F76  0000              add [eax],al
00003F78  0000              add [eax],al
00003F7A  0000              add [eax],al
00003F7C  0000              add [eax],al
00003F7E  0000              add [eax],al
00003F80  0000              add [eax],al
00003F82  0000              add [eax],al
00003F84  0000              add [eax],al
00003F86  0000              add [eax],al
00003F88  0000              add [eax],al
00003F8A  0000              add [eax],al
00003F8C  0000              add [eax],al
00003F8E  0000              add [eax],al
00003F90  0000              add [eax],al
00003F92  0000              add [eax],al
00003F94  0000              add [eax],al
00003F96  0000              add [eax],al
00003F98  0000              add [eax],al
00003F9A  0000              add [eax],al
00003F9C  0000              add [eax],al
00003F9E  0000              add [eax],al
00003FA0  0000              add [eax],al
00003FA2  0000              add [eax],al
00003FA4  0000              add [eax],al
00003FA6  0000              add [eax],al
00003FA8  0000              add [eax],al
00003FAA  0000              add [eax],al
00003FAC  0000              add [eax],al
00003FAE  0000              add [eax],al
00003FB0  0000              add [eax],al
00003FB2  0000              add [eax],al
00003FB4  0000              add [eax],al
00003FB6  0000              add [eax],al
00003FB8  0000              add [eax],al
00003FBA  0000              add [eax],al
00003FBC  0000              add [eax],al
00003FBE  0000              add [eax],al
00003FC0  0000              add [eax],al
00003FC2  0000              add [eax],al
00003FC4  0000              add [eax],al
00003FC6  0000              add [eax],al
00003FC8  0000              add [eax],al
00003FCA  0000              add [eax],al
00003FCC  0000              add [eax],al
00003FCE  0000              add [eax],al
00003FD0  0000              add [eax],al
00003FD2  0000              add [eax],al
00003FD4  0000              add [eax],al
00003FD6  0000              add [eax],al
00003FD8  0000              add [eax],al
00003FDA  0000              add [eax],al
00003FDC  0000              add [eax],al
00003FDE  0000              add [eax],al
00003FE0  0000              add [eax],al
00003FE2  0000              add [eax],al
00003FE4  0000              add [eax],al
00003FE6  0000              add [eax],al
00003FE8  0000              add [eax],al
00003FEA  0000              add [eax],al
00003FEC  0000              add [eax],al
00003FEE  0000              add [eax],al
00003FF0  0000              add [eax],al
00003FF2  0000              add [eax],al
00003FF4  0000              add [eax],al
00003FF6  0000              add [eax],al
00003FF8  0000              add [eax],al
00003FFA  0000              add [eax],al
00003FFC  0000              add [eax],al
00003FFE  0000              add [eax],al
00004000  0000              add [eax],al
00004002  0000              add [eax],al
00004004  0000              add [eax],al
00004006  0000              add [eax],al
00004008  0000              add [eax],al
0000400A  0000              add [eax],al
0000400C  0000              add [eax],al
0000400E  0000              add [eax],al
00004010  0000              add [eax],al
00004012  0000              add [eax],al
00004014  0000              add [eax],al
00004016  0000              add [eax],al
00004018  0000              add [eax],al
0000401A  0000              add [eax],al
0000401C  0000              add [eax],al
0000401E  0000              add [eax],al
00004020  0000              add [eax],al
00004022  0000              add [eax],al
00004024  0000              add [eax],al
00004026  0000              add [eax],al
00004028  0000              add [eax],al
0000402A  0000              add [eax],al
0000402C  0000              add [eax],al
0000402E  0000              add [eax],al
00004030  0000              add [eax],al
00004032  0000              add [eax],al
00004034  0000              add [eax],al
00004036  0000              add [eax],al
00004038  0000              add [eax],al
0000403A  0000              add [eax],al
0000403C  0000              add [eax],al
0000403E  0000              add [eax],al
00004040  0000              add [eax],al
00004042  0000              add [eax],al
00004044  0000              add [eax],al
00004046  0000              add [eax],al
00004048  0000              add [eax],al
0000404A  0000              add [eax],al
0000404C  0000              add [eax],al
0000404E  0000              add [eax],al
00004050  0000              add [eax],al
00004052  0000              add [eax],al
00004054  0000              add [eax],al
00004056  0000              add [eax],al
00004058  0000              add [eax],al
0000405A  0000              add [eax],al
0000405C  0000              add [eax],al
0000405E  0000              add [eax],al
00004060  0000              add [eax],al
00004062  0000              add [eax],al
00004064  0000              add [eax],al
00004066  0000              add [eax],al
00004068  0000              add [eax],al
0000406A  0000              add [eax],al
0000406C  0000              add [eax],al
0000406E  0000              add [eax],al
00004070  0000              add [eax],al
00004072  0000              add [eax],al
00004074  0000              add [eax],al
00004076  0000              add [eax],al
00004078  0000              add [eax],al
0000407A  0000              add [eax],al
0000407C  0000              add [eax],al
0000407E  0000              add [eax],al
00004080  0000              add [eax],al
00004082  0000              add [eax],al
00004084  0000              add [eax],al
00004086  0000              add [eax],al
00004088  0000              add [eax],al
0000408A  0000              add [eax],al
0000408C  0000              add [eax],al
0000408E  0000              add [eax],al
00004090  0000              add [eax],al
00004092  0000              add [eax],al
00004094  0000              add [eax],al
00004096  0000              add [eax],al
00004098  0000              add [eax],al
0000409A  0000              add [eax],al
0000409C  0000              add [eax],al
0000409E  0000              add [eax],al
000040A0  0000              add [eax],al
000040A2  0000              add [eax],al
000040A4  0000              add [eax],al
000040A6  0000              add [eax],al
000040A8  0000              add [eax],al
000040AA  0000              add [eax],al
000040AC  0000              add [eax],al
000040AE  0000              add [eax],al
000040B0  0000              add [eax],al
000040B2  0000              add [eax],al
000040B4  0000              add [eax],al
000040B6  0000              add [eax],al
000040B8  0000              add [eax],al
000040BA  0000              add [eax],al
000040BC  0000              add [eax],al
000040BE  0000              add [eax],al
000040C0  0000              add [eax],al
000040C2  0000              add [eax],al
000040C4  0000              add [eax],al
000040C6  0000              add [eax],al
000040C8  0000              add [eax],al
000040CA  0000              add [eax],al
000040CC  0000              add [eax],al
000040CE  0000              add [eax],al
000040D0  0000              add [eax],al
000040D2  0000              add [eax],al
000040D4  0000              add [eax],al
000040D6  0000              add [eax],al
000040D8  0000              add [eax],al
000040DA  0000              add [eax],al
000040DC  0000              add [eax],al
000040DE  0000              add [eax],al
000040E0  0000              add [eax],al
000040E2  0000              add [eax],al
000040E4  0000              add [eax],al
000040E6  0000              add [eax],al
000040E8  0000              add [eax],al
000040EA  0000              add [eax],al
000040EC  0000              add [eax],al
000040EE  0000              add [eax],al
000040F0  0000              add [eax],al
000040F2  0000              add [eax],al
000040F4  0000              add [eax],al
000040F6  0000              add [eax],al
000040F8  0000              add [eax],al
000040FA  0000              add [eax],al
000040FC  0000              add [eax],al
000040FE  0000              add [eax],al
00004100  0000              add [eax],al
00004102  0000              add [eax],al
00004104  0000              add [eax],al
00004106  0000              add [eax],al
00004108  0000              add [eax],al
0000410A  0000              add [eax],al
0000410C  0000              add [eax],al
0000410E  0000              add [eax],al
00004110  0000              add [eax],al
00004112  0000              add [eax],al
00004114  0000              add [eax],al
00004116  0000              add [eax],al
00004118  0000              add [eax],al
0000411A  0000              add [eax],al
0000411C  0000              add [eax],al
0000411E  0000              add [eax],al
00004120  0000              add [eax],al
00004122  0000              add [eax],al
00004124  0000              add [eax],al
00004126  0000              add [eax],al
00004128  0000              add [eax],al
0000412A  0000              add [eax],al
0000412C  0000              add [eax],al
0000412E  0000              add [eax],al
00004130  0000              add [eax],al
00004132  0000              add [eax],al
00004134  0000              add [eax],al
00004136  0000              add [eax],al
00004138  0000              add [eax],al
0000413A  0000              add [eax],al
0000413C  0000              add [eax],al
0000413E  0000              add [eax],al
00004140  0000              add [eax],al
00004142  0000              add [eax],al
00004144  0000              add [eax],al
00004146  0000              add [eax],al
00004148  0000              add [eax],al
0000414A  0000              add [eax],al
0000414C  0000              add [eax],al
0000414E  0000              add [eax],al
00004150  0000              add [eax],al
00004152  0000              add [eax],al
00004154  0000              add [eax],al
00004156  0000              add [eax],al
00004158  0000              add [eax],al
0000415A  0000              add [eax],al
0000415C  0000              add [eax],al
0000415E  0000              add [eax],al
00004160  0000              add [eax],al
00004162  0000              add [eax],al
00004164  0000              add [eax],al
00004166  0000              add [eax],al
00004168  0000              add [eax],al
0000416A  0000              add [eax],al
0000416C  0000              add [eax],al
0000416E  0000              add [eax],al
00004170  0000              add [eax],al
00004172  0000              add [eax],al
00004174  0000              add [eax],al
00004176  0000              add [eax],al
00004178  0000              add [eax],al
0000417A  0000              add [eax],al
0000417C  0000              add [eax],al
0000417E  0000              add [eax],al
00004180  0000              add [eax],al
00004182  0000              add [eax],al
00004184  0000              add [eax],al
00004186  0000              add [eax],al
00004188  0000              add [eax],al
0000418A  0000              add [eax],al
0000418C  0000              add [eax],al
0000418E  0000              add [eax],al
00004190  0000              add [eax],al
00004192  0000              add [eax],al
00004194  0000              add [eax],al
00004196  0000              add [eax],al
00004198  0000              add [eax],al
0000419A  0000              add [eax],al
0000419C  0000              add [eax],al
0000419E  0000              add [eax],al
000041A0  0000              add [eax],al
000041A2  0000              add [eax],al
000041A4  0000              add [eax],al
000041A6  0000              add [eax],al
000041A8  0000              add [eax],al
000041AA  0000              add [eax],al
000041AC  0000              add [eax],al
000041AE  0000              add [eax],al
000041B0  0000              add [eax],al
000041B2  0000              add [eax],al
000041B4  0000              add [eax],al
000041B6  0000              add [eax],al
000041B8  0000              add [eax],al
000041BA  0000              add [eax],al
000041BC  0000              add [eax],al
000041BE  0000              add [eax],al
000041C0  0000              add [eax],al
000041C2  0000              add [eax],al
000041C4  0000              add [eax],al
000041C6  0000              add [eax],al
000041C8  0000              add [eax],al
000041CA  0000              add [eax],al
000041CC  0000              add [eax],al
000041CE  0000              add [eax],al
000041D0  0000              add [eax],al
000041D2  0000              add [eax],al
000041D4  0000              add [eax],al
000041D6  0000              add [eax],al
000041D8  0000              add [eax],al
000041DA  0000              add [eax],al
000041DC  0000              add [eax],al
000041DE  0000              add [eax],al
000041E0  0000              add [eax],al
000041E2  0000              add [eax],al
000041E4  0000              add [eax],al
000041E6  0000              add [eax],al
000041E8  0000              add [eax],al
000041EA  0000              add [eax],al
000041EC  0000              add [eax],al
000041EE  0000              add [eax],al
000041F0  0000              add [eax],al
000041F2  0000              add [eax],al
000041F4  0000              add [eax],al
000041F6  0000              add [eax],al
000041F8  0000              add [eax],al
000041FA  0000              add [eax],al
000041FC  0000              add [eax],al
000041FE  0000              add [eax],al
00004200  0000              add [eax],al
00004202  0000              add [eax],al
00004204  0000              add [eax],al
00004206  0000              add [eax],al
00004208  0000              add [eax],al
0000420A  0000              add [eax],al
0000420C  0000              add [eax],al
0000420E  0000              add [eax],al
00004210  0000              add [eax],al
00004212  0000              add [eax],al
00004214  0000              add [eax],al
00004216  0000              add [eax],al
00004218  0000              add [eax],al
0000421A  0000              add [eax],al
0000421C  0000              add [eax],al
0000421E  0000              add [eax],al
00004220  0000              add [eax],al
00004222  0000              add [eax],al
00004224  0000              add [eax],al
00004226  0000              add [eax],al
00004228  0000              add [eax],al
0000422A  0000              add [eax],al
0000422C  0000              add [eax],al
0000422E  0000              add [eax],al
00004230  0000              add [eax],al
00004232  0000              add [eax],al
00004234  0000              add [eax],al
00004236  0000              add [eax],al
00004238  0000              add [eax],al
0000423A  0000              add [eax],al
0000423C  0000              add [eax],al
0000423E  0000              add [eax],al
00004240  0000              add [eax],al
00004242  0000              add [eax],al
00004244  0000              add [eax],al
00004246  0000              add [eax],al
00004248  0000              add [eax],al
0000424A  0000              add [eax],al
0000424C  0000              add [eax],al
0000424E  0000              add [eax],al
00004250  0000              add [eax],al
00004252  0000              add [eax],al
00004254  0000              add [eax],al
00004256  0000              add [eax],al
00004258  0000              add [eax],al
0000425A  0000              add [eax],al
0000425C  0000              add [eax],al
0000425E  0000              add [eax],al
00004260  0000              add [eax],al
00004262  0000              add [eax],al
00004264  0000              add [eax],al
00004266  0000              add [eax],al
00004268  0000              add [eax],al
0000426A  0000              add [eax],al
0000426C  0000              add [eax],al
0000426E  0000              add [eax],al
00004270  0000              add [eax],al
00004272  0000              add [eax],al
00004274  0000              add [eax],al
00004276  0000              add [eax],al
00004278  0000              add [eax],al
0000427A  0000              add [eax],al
0000427C  0000              add [eax],al
0000427E  0000              add [eax],al
00004280  0000              add [eax],al
00004282  0000              add [eax],al
00004284  0000              add [eax],al
00004286  0000              add [eax],al
00004288  0000              add [eax],al
0000428A  0000              add [eax],al
0000428C  0000              add [eax],al
0000428E  0000              add [eax],al
00004290  0000              add [eax],al
00004292  0000              add [eax],al
00004294  0000              add [eax],al
00004296  0000              add [eax],al
00004298  0000              add [eax],al
0000429A  0000              add [eax],al
0000429C  0000              add [eax],al
0000429E  0000              add [eax],al
000042A0  0000              add [eax],al
000042A2  0000              add [eax],al
000042A4  0000              add [eax],al
000042A6  0000              add [eax],al
000042A8  0000              add [eax],al
000042AA  0000              add [eax],al
000042AC  0000              add [eax],al
000042AE  0000              add [eax],al
000042B0  0000              add [eax],al
000042B2  0000              add [eax],al
000042B4  0000              add [eax],al
000042B6  0000              add [eax],al
000042B8  0000              add [eax],al
000042BA  0000              add [eax],al
000042BC  0000              add [eax],al
000042BE  0000              add [eax],al
000042C0  0000              add [eax],al
000042C2  0000              add [eax],al
000042C4  0000              add [eax],al
000042C6  0000              add [eax],al
000042C8  0000              add [eax],al
000042CA  0000              add [eax],al
000042CC  0000              add [eax],al
000042CE  0000              add [eax],al
000042D0  0000              add [eax],al
000042D2  0000              add [eax],al
000042D4  0000              add [eax],al
000042D6  0000              add [eax],al
000042D8  0000              add [eax],al
000042DA  0000              add [eax],al
000042DC  0000              add [eax],al
000042DE  0000              add [eax],al
000042E0  0000              add [eax],al
000042E2  0000              add [eax],al
000042E4  0000              add [eax],al
000042E6  0000              add [eax],al
000042E8  0000              add [eax],al
000042EA  0000              add [eax],al
000042EC  0000              add [eax],al
000042EE  0000              add [eax],al
000042F0  0000              add [eax],al
000042F2  0000              add [eax],al
000042F4  0000              add [eax],al
000042F6  0000              add [eax],al
000042F8  0000              add [eax],al
000042FA  0000              add [eax],al
000042FC  0000              add [eax],al
000042FE  0000              add [eax],al
00004300  0000              add [eax],al
00004302  0000              add [eax],al
00004304  0000              add [eax],al
00004306  0000              add [eax],al
00004308  0000              add [eax],al
0000430A  0000              add [eax],al
0000430C  0000              add [eax],al
0000430E  0000              add [eax],al
00004310  0000              add [eax],al
00004312  0000              add [eax],al
00004314  0000              add [eax],al
00004316  0000              add [eax],al
00004318  0000              add [eax],al
0000431A  0000              add [eax],al
0000431C  0000              add [eax],al
0000431E  0000              add [eax],al
00004320  0000              add [eax],al
00004322  0000              add [eax],al
00004324  0000              add [eax],al
00004326  0000              add [eax],al
00004328  0000              add [eax],al
0000432A  0000              add [eax],al
0000432C  0000              add [eax],al
0000432E  0000              add [eax],al
00004330  0000              add [eax],al
00004332  0000              add [eax],al
00004334  0000              add [eax],al
00004336  0000              add [eax],al
00004338  0000              add [eax],al
0000433A  0000              add [eax],al
0000433C  0000              add [eax],al
0000433E  0000              add [eax],al
00004340  0000              add [eax],al
00004342  0000              add [eax],al
00004344  0000              add [eax],al
00004346  0000              add [eax],al
00004348  0000              add [eax],al
0000434A  0000              add [eax],al
0000434C  0000              add [eax],al
0000434E  0000              add [eax],al
00004350  0000              add [eax],al
00004352  0000              add [eax],al
00004354  0000              add [eax],al
00004356  0000              add [eax],al
00004358  0000              add [eax],al
0000435A  0000              add [eax],al
0000435C  0000              add [eax],al
0000435E  0000              add [eax],al
00004360  0000              add [eax],al
00004362  0000              add [eax],al
00004364  0000              add [eax],al
00004366  0000              add [eax],al
00004368  0000              add [eax],al
0000436A  0000              add [eax],al
0000436C  0000              add [eax],al
0000436E  0000              add [eax],al
00004370  0000              add [eax],al
00004372  0000              add [eax],al
00004374  0000              add [eax],al
00004376  0000              add [eax],al
00004378  0000              add [eax],al
0000437A  0000              add [eax],al
0000437C  0000              add [eax],al
0000437E  0000              add [eax],al
00004380  0000              add [eax],al
00004382  0000              add [eax],al
00004384  0000              add [eax],al
00004386  0000              add [eax],al
00004388  0000              add [eax],al
0000438A  0000              add [eax],al
0000438C  0000              add [eax],al
0000438E  0000              add [eax],al
00004390  0000              add [eax],al
00004392  0000              add [eax],al
00004394  0000              add [eax],al
00004396  0000              add [eax],al
00004398  0000              add [eax],al
0000439A  0000              add [eax],al
0000439C  0000              add [eax],al
0000439E  0000              add [eax],al
000043A0  0000              add [eax],al
000043A2  0000              add [eax],al
000043A4  0000              add [eax],al
000043A6  0000              add [eax],al
000043A8  0000              add [eax],al
000043AA  0000              add [eax],al
000043AC  0000              add [eax],al
000043AE  0000              add [eax],al
000043B0  0000              add [eax],al
000043B2  0000              add [eax],al
000043B4  0000              add [eax],al
000043B6  0000              add [eax],al
000043B8  0000              add [eax],al
000043BA  0000              add [eax],al
000043BC  0000              add [eax],al
000043BE  0000              add [eax],al
000043C0  0000              add [eax],al
000043C2  0000              add [eax],al
000043C4  0000              add [eax],al
000043C6  0000              add [eax],al
000043C8  0000              add [eax],al
000043CA  0000              add [eax],al
000043CC  0000              add [eax],al
000043CE  0000              add [eax],al
000043D0  0000              add [eax],al
000043D2  0000              add [eax],al
000043D4  0000              add [eax],al
000043D6  0000              add [eax],al
000043D8  0000              add [eax],al
000043DA  0000              add [eax],al
000043DC  0000              add [eax],al
000043DE  0000              add [eax],al
000043E0  0000              add [eax],al
000043E2  0000              add [eax],al
000043E4  0000              add [eax],al
000043E6  0000              add [eax],al
000043E8  0000              add [eax],al
000043EA  0000              add [eax],al
000043EC  0000              add [eax],al
000043EE  0000              add [eax],al
000043F0  0000              add [eax],al
000043F2  0000              add [eax],al
000043F4  0000              add [eax],al
000043F6  0000              add [eax],al
000043F8  0000              add [eax],al
000043FA  0000              add [eax],al
000043FC  0000              add [eax],al
000043FE  0000              add [eax],al
00004400  0000              add [eax],al
00004402  0000              add [eax],al
00004404  0000              add [eax],al
00004406  0000              add [eax],al
00004408  0000              add [eax],al
0000440A  0000              add [eax],al
0000440C  0000              add [eax],al
0000440E  0000              add [eax],al
00004410  0000              add [eax],al
00004412  0000              add [eax],al
00004414  0000              add [eax],al
00004416  0000              add [eax],al
00004418  0000              add [eax],al
0000441A  0000              add [eax],al
0000441C  0000              add [eax],al
0000441E  0000              add [eax],al
00004420  0000              add [eax],al
00004422  0000              add [eax],al
00004424  0000              add [eax],al
00004426  0000              add [eax],al
00004428  0000              add [eax],al
0000442A  0000              add [eax],al
0000442C  0000              add [eax],al
0000442E  0000              add [eax],al
00004430  0000              add [eax],al
00004432  0000              add [eax],al
00004434  0000              add [eax],al
00004436  0000              add [eax],al
00004438  0000              add [eax],al
0000443A  0000              add [eax],al
0000443C  0000              add [eax],al
0000443E  0000              add [eax],al
00004440  0000              add [eax],al
00004442  0000              add [eax],al
00004444  0000              add [eax],al
00004446  0000              add [eax],al
00004448  0000              add [eax],al
0000444A  0000              add [eax],al
0000444C  0000              add [eax],al
0000444E  0000              add [eax],al
00004450  0000              add [eax],al
00004452  0000              add [eax],al
00004454  0000              add [eax],al
00004456  0000              add [eax],al
00004458  0000              add [eax],al
0000445A  0000              add [eax],al
0000445C  0000              add [eax],al
0000445E  0000              add [eax],al
00004460  0000              add [eax],al
00004462  0000              add [eax],al
00004464  0000              add [eax],al
00004466  0000              add [eax],al
00004468  0000              add [eax],al
0000446A  0000              add [eax],al
0000446C  0000              add [eax],al
0000446E  0000              add [eax],al
00004470  0000              add [eax],al
00004472  0000              add [eax],al
00004474  0000              add [eax],al
00004476  0000              add [eax],al
00004478  0000              add [eax],al
0000447A  0000              add [eax],al
0000447C  0000              add [eax],al
0000447E  0000              add [eax],al
00004480  0000              add [eax],al
00004482  0000              add [eax],al
00004484  0000              add [eax],al
00004486  0000              add [eax],al
00004488  0000              add [eax],al
0000448A  0000              add [eax],al
0000448C  0000              add [eax],al
0000448E  0000              add [eax],al
00004490  0000              add [eax],al
00004492  0000              add [eax],al
00004494  0000              add [eax],al
00004496  0000              add [eax],al
00004498  0000              add [eax],al
0000449A  0000              add [eax],al
0000449C  0000              add [eax],al
0000449E  0000              add [eax],al
000044A0  0000              add [eax],al
000044A2  0000              add [eax],al
000044A4  0000              add [eax],al
000044A6  0000              add [eax],al
000044A8  0000              add [eax],al
000044AA  0000              add [eax],al
000044AC  0000              add [eax],al
000044AE  0000              add [eax],al
000044B0  0000              add [eax],al
000044B2  0000              add [eax],al
000044B4  0000              add [eax],al
000044B6  0000              add [eax],al
000044B8  0000              add [eax],al
000044BA  0000              add [eax],al
000044BC  0000              add [eax],al
000044BE  0000              add [eax],al
000044C0  0000              add [eax],al
000044C2  0000              add [eax],al
000044C4  0000              add [eax],al
000044C6  0000              add [eax],al
000044C8  0000              add [eax],al
000044CA  0000              add [eax],al
000044CC  0000              add [eax],al
000044CE  0000              add [eax],al
000044D0  0000              add [eax],al
000044D2  0000              add [eax],al
000044D4  0000              add [eax],al
000044D6  0000              add [eax],al
000044D8  0000              add [eax],al
000044DA  0000              add [eax],al
000044DC  0000              add [eax],al
000044DE  0000              add [eax],al
000044E0  0000              add [eax],al
000044E2  0000              add [eax],al
000044E4  0000              add [eax],al
000044E6  0000              add [eax],al
000044E8  0000              add [eax],al
000044EA  0000              add [eax],al
000044EC  0000              add [eax],al
000044EE  0000              add [eax],al
000044F0  0000              add [eax],al
000044F2  0000              add [eax],al
000044F4  0000              add [eax],al
000044F6  0000              add [eax],al
000044F8  0000              add [eax],al
000044FA  0000              add [eax],al
000044FC  0000              add [eax],al
000044FE  0000              add [eax],al
00004500  0000              add [eax],al
00004502  0000              add [eax],al
00004504  0000              add [eax],al
00004506  0000              add [eax],al
00004508  0000              add [eax],al
0000450A  0000              add [eax],al
0000450C  0000              add [eax],al
0000450E  0000              add [eax],al
00004510  0000              add [eax],al
00004512  0000              add [eax],al
00004514  0000              add [eax],al
00004516  0000              add [eax],al
00004518  0000              add [eax],al
0000451A  0000              add [eax],al
0000451C  0000              add [eax],al
0000451E  0000              add [eax],al
00004520  0000              add [eax],al
00004522  0000              add [eax],al
00004524  0000              add [eax],al
00004526  0000              add [eax],al
00004528  0000              add [eax],al
0000452A  0000              add [eax],al
0000452C  0000              add [eax],al
0000452E  0000              add [eax],al
00004530  0000              add [eax],al
00004532  0000              add [eax],al
00004534  0000              add [eax],al
00004536  0000              add [eax],al
00004538  0000              add [eax],al
0000453A  0000              add [eax],al
0000453C  0000              add [eax],al
0000453E  0000              add [eax],al
00004540  0000              add [eax],al
00004542  0000              add [eax],al
00004544  0000              add [eax],al
00004546  0000              add [eax],al
00004548  0000              add [eax],al
0000454A  0000              add [eax],al
0000454C  0000              add [eax],al
0000454E  0000              add [eax],al
00004550  0000              add [eax],al
00004552  0000              add [eax],al
00004554  0000              add [eax],al
00004556  0000              add [eax],al
00004558  0000              add [eax],al
0000455A  0000              add [eax],al
0000455C  0000              add [eax],al
0000455E  0000              add [eax],al
00004560  0000              add [eax],al
00004562  0000              add [eax],al
00004564  0000              add [eax],al
00004566  0000              add [eax],al
00004568  0000              add [eax],al
0000456A  0000              add [eax],al
0000456C  0000              add [eax],al
0000456E  0000              add [eax],al
00004570  0000              add [eax],al
00004572  0000              add [eax],al
00004574  0000              add [eax],al
00004576  0000              add [eax],al
00004578  0000              add [eax],al
0000457A  0000              add [eax],al
0000457C  0000              add [eax],al
0000457E  0000              add [eax],al
00004580  0000              add [eax],al
00004582  0000              add [eax],al
00004584  0000              add [eax],al
00004586  0000              add [eax],al
00004588  0000              add [eax],al
0000458A  0000              add [eax],al
0000458C  0000              add [eax],al
0000458E  0000              add [eax],al
00004590  0000              add [eax],al
00004592  0000              add [eax],al
00004594  0000              add [eax],al
00004596  0000              add [eax],al
00004598  0000              add [eax],al
0000459A  0000              add [eax],al
0000459C  0000              add [eax],al
0000459E  0000              add [eax],al
000045A0  0000              add [eax],al
000045A2  0000              add [eax],al
000045A4  0000              add [eax],al
000045A6  0000              add [eax],al
000045A8  0000              add [eax],al
000045AA  0000              add [eax],al
000045AC  0000              add [eax],al
000045AE  0000              add [eax],al
000045B0  0000              add [eax],al
000045B2  0000              add [eax],al
000045B4  0000              add [eax],al
000045B6  0000              add [eax],al
000045B8  0000              add [eax],al
000045BA  0000              add [eax],al
000045BC  0000              add [eax],al
000045BE  0000              add [eax],al
000045C0  0000              add [eax],al
000045C2  0000              add [eax],al
000045C4  0000              add [eax],al
000045C6  0000              add [eax],al
000045C8  0000              add [eax],al
000045CA  0000              add [eax],al
000045CC  0000              add [eax],al
000045CE  0000              add [eax],al
000045D0  0000              add [eax],al
000045D2  0000              add [eax],al
000045D4  0000              add [eax],al
000045D6  0000              add [eax],al
000045D8  0000              add [eax],al
000045DA  0000              add [eax],al
000045DC  0000              add [eax],al
000045DE  0000              add [eax],al
000045E0  0000              add [eax],al
000045E2  0000              add [eax],al
000045E4  0000              add [eax],al
000045E6  0000              add [eax],al
000045E8  0000              add [eax],al
000045EA  0000              add [eax],al
000045EC  0000              add [eax],al
000045EE  0000              add [eax],al
000045F0  0000              add [eax],al
000045F2  0000              add [eax],al
000045F4  0000              add [eax],al
000045F6  0000              add [eax],al
000045F8  0000              add [eax],al
000045FA  0000              add [eax],al
000045FC  0000              add [eax],al
000045FE  0000              add [eax],al
00004600  0000              add [eax],al
00004602  0000              add [eax],al
00004604  0000              add [eax],al
00004606  0000              add [eax],al
00004608  0000              add [eax],al
0000460A  0000              add [eax],al
0000460C  0000              add [eax],al
0000460E  0000              add [eax],al
00004610  0000              add [eax],al
00004612  0000              add [eax],al
00004614  0000              add [eax],al
00004616  0000              add [eax],al
00004618  0000              add [eax],al
0000461A  0000              add [eax],al
0000461C  0000              add [eax],al
0000461E  0000              add [eax],al
00004620  0000              add [eax],al
00004622  0000              add [eax],al
00004624  0000              add [eax],al
00004626  0000              add [eax],al
00004628  0000              add [eax],al
0000462A  0000              add [eax],al
0000462C  0000              add [eax],al
0000462E  0000              add [eax],al
00004630  0000              add [eax],al
00004632  0000              add [eax],al
00004634  0000              add [eax],al
00004636  0000              add [eax],al
00004638  0000              add [eax],al
0000463A  0000              add [eax],al
0000463C  0000              add [eax],al
0000463E  0000              add [eax],al
00004640  0000              add [eax],al
00004642  0000              add [eax],al
00004644  0000              add [eax],al
00004646  0000              add [eax],al
00004648  0000              add [eax],al
0000464A  0000              add [eax],al
0000464C  0000              add [eax],al
0000464E  0000              add [eax],al
00004650  0000              add [eax],al
00004652  0000              add [eax],al
00004654  0000              add [eax],al
00004656  0000              add [eax],al
00004658  0000              add [eax],al
0000465A  0000              add [eax],al
0000465C  0000              add [eax],al
0000465E  0000              add [eax],al
00004660  0000              add [eax],al
00004662  0000              add [eax],al
00004664  0000              add [eax],al
00004666  0000              add [eax],al
00004668  0000              add [eax],al
0000466A  0000              add [eax],al
0000466C  0000              add [eax],al
0000466E  0000              add [eax],al
00004670  0000              add [eax],al
00004672  0000              add [eax],al
00004674  0000              add [eax],al
00004676  0000              add [eax],al
00004678  0000              add [eax],al
0000467A  0000              add [eax],al
0000467C  0000              add [eax],al
0000467E  0000              add [eax],al
00004680  0000              add [eax],al
00004682  0000              add [eax],al
00004684  0000              add [eax],al
00004686  0000              add [eax],al
00004688  0000              add [eax],al
0000468A  0000              add [eax],al
0000468C  0000              add [eax],al
0000468E  0000              add [eax],al
00004690  0000              add [eax],al
00004692  0000              add [eax],al
00004694  0000              add [eax],al
00004696  0000              add [eax],al
00004698  0000              add [eax],al
0000469A  0000              add [eax],al
0000469C  0000              add [eax],al
0000469E  0000              add [eax],al
000046A0  0000              add [eax],al
000046A2  0000              add [eax],al
000046A4  0000              add [eax],al
000046A6  0000              add [eax],al
000046A8  0000              add [eax],al
000046AA  0000              add [eax],al
000046AC  0000              add [eax],al
000046AE  0000              add [eax],al
000046B0  0000              add [eax],al
000046B2  0000              add [eax],al
000046B4  0000              add [eax],al
000046B6  0000              add [eax],al
000046B8  0000              add [eax],al
000046BA  0000              add [eax],al
000046BC  0000              add [eax],al
000046BE  0000              add [eax],al
000046C0  0000              add [eax],al
000046C2  0000              add [eax],al
000046C4  0000              add [eax],al
000046C6  0000              add [eax],al
000046C8  0000              add [eax],al
000046CA  0000              add [eax],al
000046CC  0000              add [eax],al
000046CE  0000              add [eax],al
000046D0  0000              add [eax],al
000046D2  0000              add [eax],al
000046D4  0000              add [eax],al
000046D6  0000              add [eax],al
000046D8  0000              add [eax],al
000046DA  0000              add [eax],al
000046DC  0000              add [eax],al
000046DE  0000              add [eax],al
000046E0  0000              add [eax],al
000046E2  0000              add [eax],al
000046E4  0000              add [eax],al
000046E6  0000              add [eax],al
000046E8  0000              add [eax],al
000046EA  0000              add [eax],al
000046EC  0000              add [eax],al
000046EE  0000              add [eax],al
000046F0  0000              add [eax],al
000046F2  0000              add [eax],al
000046F4  0000              add [eax],al
000046F6  0000              add [eax],al
000046F8  0000              add [eax],al
000046FA  0000              add [eax],al
000046FC  0000              add [eax],al
000046FE  0000              add [eax],al
00004700  0000              add [eax],al
00004702  0000              add [eax],al
00004704  0000              add [eax],al
00004706  0000              add [eax],al
00004708  0000              add [eax],al
0000470A  0000              add [eax],al
0000470C  0000              add [eax],al
0000470E  0000              add [eax],al
00004710  0000              add [eax],al
00004712  0000              add [eax],al
00004714  0000              add [eax],al
00004716  0000              add [eax],al
00004718  0000              add [eax],al
0000471A  0000              add [eax],al
0000471C  0000              add [eax],al
0000471E  0000              add [eax],al
00004720  0000              add [eax],al
00004722  0000              add [eax],al
00004724  0000              add [eax],al
00004726  0000              add [eax],al
00004728  0000              add [eax],al
0000472A  0000              add [eax],al
0000472C  0000              add [eax],al
0000472E  0000              add [eax],al
00004730  0000              add [eax],al
00004732  0000              add [eax],al
00004734  0000              add [eax],al
00004736  0000              add [eax],al
00004738  0000              add [eax],al
0000473A  0000              add [eax],al
0000473C  0000              add [eax],al
0000473E  0000              add [eax],al
00004740  0000              add [eax],al
00004742  0000              add [eax],al
00004744  0000              add [eax],al
00004746  0000              add [eax],al
00004748  0000              add [eax],al
0000474A  0000              add [eax],al
0000474C  0000              add [eax],al
0000474E  0000              add [eax],al
00004750  0000              add [eax],al
00004752  0000              add [eax],al
00004754  0000              add [eax],al
00004756  0000              add [eax],al
00004758  0000              add [eax],al
0000475A  0000              add [eax],al
0000475C  0000              add [eax],al
0000475E  0000              add [eax],al
00004760  0000              add [eax],al
00004762  0000              add [eax],al
00004764  0000              add [eax],al
00004766  0000              add [eax],al
00004768  0000              add [eax],al
0000476A  0000              add [eax],al
0000476C  0000              add [eax],al
0000476E  0000              add [eax],al
00004770  0000              add [eax],al
00004772  0000              add [eax],al
00004774  0000              add [eax],al
00004776  0000              add [eax],al
00004778  0000              add [eax],al
0000477A  0000              add [eax],al
0000477C  0000              add [eax],al
0000477E  0000              add [eax],al
00004780  0000              add [eax],al
00004782  0000              add [eax],al
00004784  0000              add [eax],al
00004786  0000              add [eax],al
00004788  0000              add [eax],al
0000478A  0000              add [eax],al
0000478C  0000              add [eax],al
0000478E  0000              add [eax],al
00004790  0000              add [eax],al
00004792  0000              add [eax],al
00004794  0000              add [eax],al
00004796  0000              add [eax],al
00004798  0000              add [eax],al
0000479A  0000              add [eax],al
0000479C  0000              add [eax],al
0000479E  0000              add [eax],al
000047A0  0000              add [eax],al
000047A2  0000              add [eax],al
000047A4  0000              add [eax],al
000047A6  0000              add [eax],al
000047A8  0000              add [eax],al
000047AA  0000              add [eax],al
000047AC  0000              add [eax],al
000047AE  0000              add [eax],al
000047B0  0000              add [eax],al
000047B2  0000              add [eax],al
000047B4  0000              add [eax],al
000047B6  0000              add [eax],al
000047B8  0000              add [eax],al
000047BA  0000              add [eax],al
000047BC  0000              add [eax],al
000047BE  0000              add [eax],al
000047C0  0000              add [eax],al
000047C2  0000              add [eax],al
000047C4  0000              add [eax],al
000047C6  0000              add [eax],al
000047C8  0000              add [eax],al
000047CA  0000              add [eax],al
000047CC  0000              add [eax],al
000047CE  0000              add [eax],al
000047D0  0000              add [eax],al
000047D2  0000              add [eax],al
000047D4  0000              add [eax],al
000047D6  0000              add [eax],al
000047D8  0000              add [eax],al
000047DA  0000              add [eax],al
000047DC  0000              add [eax],al
000047DE  0000              add [eax],al
000047E0  0000              add [eax],al
000047E2  0000              add [eax],al
000047E4  0000              add [eax],al
000047E6  0000              add [eax],al
000047E8  0000              add [eax],al
000047EA  0000              add [eax],al
000047EC  0000              add [eax],al
000047EE  0000              add [eax],al
000047F0  0000              add [eax],al
000047F2  0000              add [eax],al
000047F4  0000              add [eax],al
000047F6  0000              add [eax],al
000047F8  0000              add [eax],al
000047FA  0000              add [eax],al
000047FC  0000              add [eax],al
000047FE  0000              add [eax],al
00004800  0000              add [eax],al
00004802  0000              add [eax],al
00004804  0000              add [eax],al
00004806  0000              add [eax],al
00004808  0000              add [eax],al
0000480A  0000              add [eax],al
0000480C  0000              add [eax],al
0000480E  0000              add [eax],al
00004810  0000              add [eax],al
00004812  0000              add [eax],al
00004814  0000              add [eax],al
00004816  0000              add [eax],al
00004818  0000              add [eax],al
0000481A  0000              add [eax],al
0000481C  0000              add [eax],al
0000481E  0000              add [eax],al
00004820  0000              add [eax],al
00004822  0000              add [eax],al
00004824  0000              add [eax],al
00004826  0000              add [eax],al
00004828  0000              add [eax],al
0000482A  0000              add [eax],al
0000482C  0000              add [eax],al
0000482E  0000              add [eax],al
00004830  0000              add [eax],al
00004832  0000              add [eax],al
00004834  0000              add [eax],al
00004836  0000              add [eax],al
00004838  0000              add [eax],al
0000483A  0000              add [eax],al
0000483C  0000              add [eax],al
0000483E  0000              add [eax],al
00004840  0000              add [eax],al
00004842  0000              add [eax],al
00004844  0000              add [eax],al
00004846  0000              add [eax],al
00004848  0000              add [eax],al
0000484A  0000              add [eax],al
0000484C  0000              add [eax],al
0000484E  0000              add [eax],al
00004850  0000              add [eax],al
00004852  0000              add [eax],al
00004854  0000              add [eax],al
00004856  0000              add [eax],al
00004858  0000              add [eax],al
0000485A  0000              add [eax],al
0000485C  0000              add [eax],al
0000485E  0000              add [eax],al
00004860  0000              add [eax],al
00004862  0000              add [eax],al
00004864  0000              add [eax],al
00004866  0000              add [eax],al
00004868  0000              add [eax],al
0000486A  0000              add [eax],al
0000486C  0000              add [eax],al
0000486E  0000              add [eax],al
00004870  0000              add [eax],al
00004872  0000              add [eax],al
00004874  0000              add [eax],al
00004876  0000              add [eax],al
00004878  0000              add [eax],al
0000487A  0000              add [eax],al
0000487C  0000              add [eax],al
0000487E  0000              add [eax],al
00004880  0000              add [eax],al
00004882  0000              add [eax],al
00004884  0000              add [eax],al
00004886  0000              add [eax],al
00004888  0000              add [eax],al
0000488A  0000              add [eax],al
0000488C  0000              add [eax],al
0000488E  0000              add [eax],al
00004890  0000              add [eax],al
00004892  0000              add [eax],al
00004894  0000              add [eax],al
00004896  0000              add [eax],al
00004898  0000              add [eax],al
0000489A  0000              add [eax],al
0000489C  0000              add [eax],al
0000489E  0000              add [eax],al
000048A0  0000              add [eax],al
000048A2  0000              add [eax],al
000048A4  0000              add [eax],al
000048A6  0000              add [eax],al
000048A8  0000              add [eax],al
000048AA  0000              add [eax],al
000048AC  0000              add [eax],al
000048AE  0000              add [eax],al
000048B0  0000              add [eax],al
000048B2  0000              add [eax],al
000048B4  0000              add [eax],al
000048B6  0000              add [eax],al
000048B8  0000              add [eax],al
000048BA  0000              add [eax],al
000048BC  0000              add [eax],al
000048BE  0000              add [eax],al
000048C0  0000              add [eax],al
000048C2  0000              add [eax],al
000048C4  0000              add [eax],al
000048C6  0000              add [eax],al
000048C8  0000              add [eax],al
000048CA  0000              add [eax],al
000048CC  0000              add [eax],al
000048CE  0000              add [eax],al
000048D0  0000              add [eax],al
000048D2  0000              add [eax],al
000048D4  0000              add [eax],al
000048D6  0000              add [eax],al
000048D8  0000              add [eax],al
000048DA  0000              add [eax],al
000048DC  0000              add [eax],al
000048DE  0000              add [eax],al
000048E0  0000              add [eax],al
000048E2  0000              add [eax],al
000048E4  0000              add [eax],al
000048E6  0000              add [eax],al
000048E8  0000              add [eax],al
000048EA  0000              add [eax],al
000048EC  0000              add [eax],al
000048EE  0000              add [eax],al
000048F0  0000              add [eax],al
000048F2  0000              add [eax],al
000048F4  0000              add [eax],al
000048F6  0000              add [eax],al
000048F8  0000              add [eax],al
000048FA  0000              add [eax],al
000048FC  0000              add [eax],al
000048FE  0000              add [eax],al
00004900  0000              add [eax],al
00004902  0000              add [eax],al
00004904  0000              add [eax],al
00004906  0000              add [eax],al
00004908  0000              add [eax],al
0000490A  0000              add [eax],al
0000490C  0000              add [eax],al
0000490E  0000              add [eax],al
00004910  0000              add [eax],al
00004912  0000              add [eax],al
00004914  0000              add [eax],al
00004916  0000              add [eax],al
00004918  0000              add [eax],al
0000491A  0000              add [eax],al
0000491C  0000              add [eax],al
0000491E  0000              add [eax],al
00004920  0000              add [eax],al
00004922  0000              add [eax],al
00004924  0000              add [eax],al
00004926  0000              add [eax],al
00004928  0000              add [eax],al
0000492A  0000              add [eax],al
0000492C  0000              add [eax],al
0000492E  0000              add [eax],al
00004930  0000              add [eax],al
00004932  0000              add [eax],al
00004934  0000              add [eax],al
00004936  0000              add [eax],al
00004938  0000              add [eax],al
0000493A  0000              add [eax],al
0000493C  0000              add [eax],al
0000493E  0000              add [eax],al
00004940  0000              add [eax],al
00004942  0000              add [eax],al
00004944  0000              add [eax],al
00004946  0000              add [eax],al
00004948  0000              add [eax],al
0000494A  0000              add [eax],al
0000494C  0000              add [eax],al
0000494E  0000              add [eax],al
00004950  0000              add [eax],al
00004952  0000              add [eax],al
00004954  0000              add [eax],al
00004956  0000              add [eax],al
00004958  0000              add [eax],al
0000495A  0000              add [eax],al
0000495C  0000              add [eax],al
0000495E  0000              add [eax],al
00004960  0000              add [eax],al
00004962  0000              add [eax],al
00004964  0000              add [eax],al
00004966  0000              add [eax],al
00004968  0000              add [eax],al
0000496A  0000              add [eax],al
0000496C  0000              add [eax],al
0000496E  0000              add [eax],al
00004970  0000              add [eax],al
00004972  0000              add [eax],al
00004974  0000              add [eax],al
00004976  0000              add [eax],al
00004978  0000              add [eax],al
0000497A  0000              add [eax],al
0000497C  0000              add [eax],al
0000497E  0000              add [eax],al
00004980  0000              add [eax],al
00004982  0000              add [eax],al
00004984  0000              add [eax],al
00004986  0000              add [eax],al
00004988  0000              add [eax],al
0000498A  0000              add [eax],al
0000498C  0000              add [eax],al
0000498E  0000              add [eax],al
00004990  0000              add [eax],al
00004992  0000              add [eax],al
00004994  0000              add [eax],al
00004996  0000              add [eax],al
00004998  0000              add [eax],al
0000499A  0000              add [eax],al
0000499C  0000              add [eax],al
0000499E  0000              add [eax],al
000049A0  0000              add [eax],al
000049A2  0000              add [eax],al
000049A4  0000              add [eax],al
000049A6  0000              add [eax],al
000049A8  0000              add [eax],al
000049AA  0000              add [eax],al
000049AC  0000              add [eax],al
000049AE  0000              add [eax],al
000049B0  0000              add [eax],al
000049B2  0000              add [eax],al
000049B4  0000              add [eax],al
000049B6  0000              add [eax],al
000049B8  0000              add [eax],al
000049BA  0000              add [eax],al
000049BC  0000              add [eax],al
000049BE  0000              add [eax],al
000049C0  0000              add [eax],al
000049C2  0000              add [eax],al
000049C4  0000              add [eax],al
000049C6  0000              add [eax],al
000049C8  0000              add [eax],al
000049CA  0000              add [eax],al
000049CC  0000              add [eax],al
000049CE  0000              add [eax],al
000049D0  0000              add [eax],al
000049D2  0000              add [eax],al
000049D4  0000              add [eax],al
000049D6  0000              add [eax],al
000049D8  0000              add [eax],al
000049DA  0000              add [eax],al
000049DC  0000              add [eax],al
000049DE  0000              add [eax],al
000049E0  0000              add [eax],al
000049E2  0000              add [eax],al
000049E4  0000              add [eax],al
000049E6  0000              add [eax],al
000049E8  0000              add [eax],al
000049EA  0000              add [eax],al
000049EC  0000              add [eax],al
000049EE  0000              add [eax],al
000049F0  0000              add [eax],al
000049F2  0000              add [eax],al
000049F4  0000              add [eax],al
000049F6  0000              add [eax],al
000049F8  0000              add [eax],al
000049FA  0000              add [eax],al
000049FC  0000              add [eax],al
000049FE  0000              add [eax],al
00004A00  0000              add [eax],al
00004A02  0000              add [eax],al
00004A04  0000              add [eax],al
00004A06  0000              add [eax],al
00004A08  0000              add [eax],al
00004A0A  0000              add [eax],al
00004A0C  0000              add [eax],al
00004A0E  0000              add [eax],al
00004A10  0000              add [eax],al
00004A12  0000              add [eax],al
00004A14  0000              add [eax],al
00004A16  0000              add [eax],al
00004A18  0000              add [eax],al
00004A1A  0000              add [eax],al
00004A1C  0000              add [eax],al
00004A1E  0000              add [eax],al
00004A20  0000              add [eax],al
00004A22  0000              add [eax],al
00004A24  0000              add [eax],al
00004A26  0000              add [eax],al
00004A28  0000              add [eax],al
00004A2A  0000              add [eax],al
00004A2C  0000              add [eax],al
00004A2E  0000              add [eax],al
00004A30  0000              add [eax],al
00004A32  0000              add [eax],al
00004A34  0000              add [eax],al
00004A36  0000              add [eax],al
00004A38  0000              add [eax],al
00004A3A  0000              add [eax],al
00004A3C  0000              add [eax],al
00004A3E  0000              add [eax],al
00004A40  0000              add [eax],al
00004A42  0000              add [eax],al
00004A44  0000              add [eax],al
00004A46  0000              add [eax],al
00004A48  0000              add [eax],al
00004A4A  0000              add [eax],al
00004A4C  0000              add [eax],al
00004A4E  0000              add [eax],al
00004A50  0000              add [eax],al
00004A52  0000              add [eax],al
00004A54  0000              add [eax],al
00004A56  0000              add [eax],al
00004A58  0000              add [eax],al
00004A5A  0000              add [eax],al
00004A5C  0000              add [eax],al
00004A5E  0000              add [eax],al
00004A60  0000              add [eax],al
00004A62  0000              add [eax],al
00004A64  0000              add [eax],al
00004A66  0000              add [eax],al
00004A68  0000              add [eax],al
00004A6A  0000              add [eax],al
00004A6C  0000              add [eax],al
00004A6E  0000              add [eax],al
00004A70  0000              add [eax],al
00004A72  0000              add [eax],al
00004A74  0000              add [eax],al
00004A76  0000              add [eax],al
00004A78  0000              add [eax],al
00004A7A  0000              add [eax],al
00004A7C  0000              add [eax],al
00004A7E  0000              add [eax],al
00004A80  0000              add [eax],al
00004A82  0000              add [eax],al
00004A84  0000              add [eax],al
00004A86  0000              add [eax],al
00004A88  0000              add [eax],al
00004A8A  0000              add [eax],al
00004A8C  0000              add [eax],al
00004A8E  0000              add [eax],al
00004A90  0000              add [eax],al
00004A92  0000              add [eax],al
00004A94  0000              add [eax],al
00004A96  0000              add [eax],al
00004A98  0000              add [eax],al
00004A9A  0000              add [eax],al
00004A9C  0000              add [eax],al
00004A9E  0000              add [eax],al
00004AA0  0000              add [eax],al
00004AA2  0000              add [eax],al
00004AA4  0000              add [eax],al
00004AA6  0000              add [eax],al
00004AA8  0000              add [eax],al
00004AAA  0000              add [eax],al
00004AAC  0000              add [eax],al
00004AAE  0000              add [eax],al
00004AB0  0000              add [eax],al
00004AB2  0000              add [eax],al
00004AB4  0000              add [eax],al
00004AB6  0000              add [eax],al
00004AB8  0000              add [eax],al
00004ABA  0000              add [eax],al
00004ABC  0000              add [eax],al
00004ABE  0000              add [eax],al
00004AC0  0000              add [eax],al
00004AC2  0000              add [eax],al
00004AC4  0000              add [eax],al
00004AC6  0000              add [eax],al
00004AC8  0000              add [eax],al
00004ACA  0000              add [eax],al
00004ACC  0000              add [eax],al
00004ACE  0000              add [eax],al
00004AD0  0000              add [eax],al
00004AD2  0000              add [eax],al
00004AD4  0000              add [eax],al
00004AD6  0000              add [eax],al
00004AD8  0000              add [eax],al
00004ADA  0000              add [eax],al
00004ADC  0000              add [eax],al
00004ADE  0000              add [eax],al
00004AE0  0000              add [eax],al
00004AE2  0000              add [eax],al
00004AE4  0000              add [eax],al
00004AE6  0000              add [eax],al
00004AE8  0000              add [eax],al
00004AEA  0000              add [eax],al
00004AEC  0000              add [eax],al
00004AEE  0000              add [eax],al
00004AF0  0000              add [eax],al
00004AF2  0000              add [eax],al
00004AF4  0000              add [eax],al
00004AF6  0000              add [eax],al
00004AF8  0000              add [eax],al
00004AFA  0000              add [eax],al
00004AFC  0000              add [eax],al
00004AFE  0000              add [eax],al
00004B00  0000              add [eax],al
00004B02  0000              add [eax],al
00004B04  0000              add [eax],al
00004B06  0000              add [eax],al
00004B08  0000              add [eax],al
00004B0A  0000              add [eax],al
00004B0C  0000              add [eax],al
00004B0E  0000              add [eax],al
00004B10  0000              add [eax],al
00004B12  0000              add [eax],al
00004B14  0000              add [eax],al
00004B16  0000              add [eax],al
00004B18  0000              add [eax],al
00004B1A  0000              add [eax],al
00004B1C  0000              add [eax],al
00004B1E  0000              add [eax],al
00004B20  0000              add [eax],al
00004B22  0000              add [eax],al
00004B24  0000              add [eax],al
00004B26  0000              add [eax],al
00004B28  0000              add [eax],al
00004B2A  0000              add [eax],al
00004B2C  0000              add [eax],al
00004B2E  0000              add [eax],al
00004B30  0000              add [eax],al
00004B32  0000              add [eax],al
00004B34  0000              add [eax],al
00004B36  0000              add [eax],al
00004B38  0000              add [eax],al
00004B3A  0000              add [eax],al
00004B3C  0000              add [eax],al
00004B3E  0000              add [eax],al
00004B40  0000              add [eax],al
00004B42  0000              add [eax],al
00004B44  0000              add [eax],al
00004B46  0000              add [eax],al
00004B48  0000              add [eax],al
00004B4A  0000              add [eax],al
00004B4C  0000              add [eax],al
00004B4E  0000              add [eax],al
00004B50  0000              add [eax],al
00004B52  0000              add [eax],al
00004B54  0000              add [eax],al
00004B56  0000              add [eax],al
00004B58  0000              add [eax],al
00004B5A  0000              add [eax],al
00004B5C  0000              add [eax],al
00004B5E  0000              add [eax],al
00004B60  0000              add [eax],al
00004B62  0000              add [eax],al
00004B64  0000              add [eax],al
00004B66  0000              add [eax],al
00004B68  0000              add [eax],al
00004B6A  0000              add [eax],al
00004B6C  0000              add [eax],al
00004B6E  0000              add [eax],al
00004B70  0000              add [eax],al
00004B72  0000              add [eax],al
00004B74  0000              add [eax],al
00004B76  0000              add [eax],al
00004B78  0000              add [eax],al
00004B7A  0000              add [eax],al
00004B7C  0000              add [eax],al
00004B7E  0000              add [eax],al
00004B80  0000              add [eax],al
00004B82  0000              add [eax],al
00004B84  0000              add [eax],al
00004B86  0000              add [eax],al
00004B88  0000              add [eax],al
00004B8A  0000              add [eax],al
00004B8C  0000              add [eax],al
00004B8E  0000              add [eax],al
00004B90  0000              add [eax],al
00004B92  0000              add [eax],al
00004B94  0000              add [eax],al
00004B96  0000              add [eax],al
00004B98  0000              add [eax],al
00004B9A  0000              add [eax],al
00004B9C  0000              add [eax],al
00004B9E  0000              add [eax],al
00004BA0  0000              add [eax],al
00004BA2  0000              add [eax],al
00004BA4  0000              add [eax],al
00004BA6  0000              add [eax],al
00004BA8  0000              add [eax],al
00004BAA  0000              add [eax],al
00004BAC  0000              add [eax],al
00004BAE  0000              add [eax],al
00004BB0  0000              add [eax],al
00004BB2  0000              add [eax],al
00004BB4  0000              add [eax],al
00004BB6  0000              add [eax],al
00004BB8  0000              add [eax],al
00004BBA  0000              add [eax],al
00004BBC  0000              add [eax],al
00004BBE  0000              add [eax],al
00004BC0  0000              add [eax],al
00004BC2  0000              add [eax],al
00004BC4  0000              add [eax],al
00004BC6  0000              add [eax],al
00004BC8  0000              add [eax],al
00004BCA  0000              add [eax],al
00004BCC  0000              add [eax],al
00004BCE  0000              add [eax],al
00004BD0  0000              add [eax],al
00004BD2  0000              add [eax],al
00004BD4  0000              add [eax],al
00004BD6  0000              add [eax],al
00004BD8  0000              add [eax],al
00004BDA  0000              add [eax],al
00004BDC  0000              add [eax],al
00004BDE  0000              add [eax],al
00004BE0  0000              add [eax],al
00004BE2  0000              add [eax],al
00004BE4  0000              add [eax],al
00004BE6  0000              add [eax],al
00004BE8  0000              add [eax],al
00004BEA  0000              add [eax],al
00004BEC  0000              add [eax],al
00004BEE  0000              add [eax],al
00004BF0  0000              add [eax],al
00004BF2  0000              add [eax],al
00004BF4  0000              add [eax],al
00004BF6  0000              add [eax],al
00004BF8  0000              add [eax],al
00004BFA  0000              add [eax],al
00004BFC  0000              add [eax],al
00004BFE  0000              add [eax],al
00004C00  0000              add [eax],al
00004C02  0000              add [eax],al
00004C04  0000              add [eax],al
00004C06  0000              add [eax],al
00004C08  0000              add [eax],al
00004C0A  0000              add [eax],al
00004C0C  0000              add [eax],al
00004C0E  0000              add [eax],al
00004C10  0000              add [eax],al
00004C12  0000              add [eax],al
00004C14  0000              add [eax],al
00004C16  0000              add [eax],al
00004C18  0000              add [eax],al
00004C1A  0000              add [eax],al
00004C1C  0000              add [eax],al
00004C1E  0000              add [eax],al
00004C20  0000              add [eax],al
00004C22  0000              add [eax],al
00004C24  0000              add [eax],al
00004C26  0000              add [eax],al
00004C28  0000              add [eax],al
00004C2A  0000              add [eax],al
00004C2C  0000              add [eax],al
00004C2E  0000              add [eax],al
00004C30  0000              add [eax],al
00004C32  0000              add [eax],al
00004C34  0000              add [eax],al
00004C36  0000              add [eax],al
00004C38  0000              add [eax],al
00004C3A  0000              add [eax],al
00004C3C  0000              add [eax],al
00004C3E  0000              add [eax],al
00004C40  0000              add [eax],al
00004C42  0000              add [eax],al
00004C44  0000              add [eax],al
00004C46  0000              add [eax],al
00004C48  0000              add [eax],al
00004C4A  0000              add [eax],al
00004C4C  0000              add [eax],al
00004C4E  0000              add [eax],al
00004C50  0000              add [eax],al
00004C52  0000              add [eax],al
00004C54  0000              add [eax],al
00004C56  0000              add [eax],al
00004C58  0000              add [eax],al
00004C5A  0000              add [eax],al
00004C5C  0000              add [eax],al
00004C5E  0000              add [eax],al
00004C60  0000              add [eax],al
00004C62  0000              add [eax],al
00004C64  0000              add [eax],al
00004C66  0000              add [eax],al
00004C68  0000              add [eax],al
00004C6A  0000              add [eax],al
00004C6C  0000              add [eax],al
00004C6E  0000              add [eax],al
00004C70  0000              add [eax],al
00004C72  0000              add [eax],al
00004C74  0000              add [eax],al
00004C76  0000              add [eax],al
00004C78  0000              add [eax],al
00004C7A  0000              add [eax],al
00004C7C  0000              add [eax],al
00004C7E  0000              add [eax],al
00004C80  0000              add [eax],al
00004C82  0000              add [eax],al
00004C84  0000              add [eax],al
00004C86  0000              add [eax],al
00004C88  0000              add [eax],al
00004C8A  0000              add [eax],al
00004C8C  0000              add [eax],al
00004C8E  0000              add [eax],al
00004C90  0000              add [eax],al
00004C92  0000              add [eax],al
00004C94  0000              add [eax],al
00004C96  0000              add [eax],al
00004C98  0000              add [eax],al
00004C9A  0000              add [eax],al
00004C9C  0000              add [eax],al
00004C9E  0000              add [eax],al
00004CA0  0000              add [eax],al
00004CA2  0000              add [eax],al
00004CA4  0000              add [eax],al
00004CA6  0000              add [eax],al
00004CA8  0000              add [eax],al
00004CAA  0000              add [eax],al
00004CAC  0000              add [eax],al
00004CAE  0000              add [eax],al
00004CB0  0000              add [eax],al
00004CB2  0000              add [eax],al
00004CB4  0000              add [eax],al
00004CB6  0000              add [eax],al
00004CB8  0000              add [eax],al
00004CBA  0000              add [eax],al
00004CBC  0000              add [eax],al
00004CBE  0000              add [eax],al
00004CC0  0000              add [eax],al
00004CC2  0000              add [eax],al
00004CC4  0000              add [eax],al
00004CC6  0000              add [eax],al
00004CC8  0000              add [eax],al
00004CCA  0000              add [eax],al
00004CCC  0000              add [eax],al
00004CCE  0000              add [eax],al
00004CD0  0000              add [eax],al
00004CD2  0000              add [eax],al
00004CD4  0000              add [eax],al
00004CD6  0000              add [eax],al
00004CD8  0000              add [eax],al
00004CDA  0000              add [eax],al
00004CDC  0000              add [eax],al
00004CDE  0000              add [eax],al
00004CE0  0000              add [eax],al
00004CE2  0000              add [eax],al
00004CE4  0000              add [eax],al
00004CE6  0000              add [eax],al
00004CE8  0000              add [eax],al
00004CEA  0000              add [eax],al
00004CEC  0000              add [eax],al
00004CEE  0000              add [eax],al
00004CF0  0000              add [eax],al
00004CF2  0000              add [eax],al
00004CF4  0000              add [eax],al
00004CF6  0000              add [eax],al
00004CF8  0000              add [eax],al
00004CFA  0000              add [eax],al
00004CFC  0000              add [eax],al
00004CFE  0000              add [eax],al
00004D00  0000              add [eax],al
00004D02  0000              add [eax],al
00004D04  0000              add [eax],al
00004D06  0000              add [eax],al
00004D08  0000              add [eax],al
00004D0A  0000              add [eax],al
00004D0C  0000              add [eax],al
00004D0E  0000              add [eax],al
00004D10  0000              add [eax],al
00004D12  0000              add [eax],al
00004D14  0000              add [eax],al
00004D16  0000              add [eax],al
00004D18  0000              add [eax],al
00004D1A  0000              add [eax],al
00004D1C  0000              add [eax],al
00004D1E  0000              add [eax],al
00004D20  0000              add [eax],al
00004D22  0000              add [eax],al
00004D24  0000              add [eax],al
00004D26  0000              add [eax],al
00004D28  0000              add [eax],al
00004D2A  0000              add [eax],al
00004D2C  0000              add [eax],al
00004D2E  0000              add [eax],al
00004D30  0000              add [eax],al
00004D32  0000              add [eax],al
00004D34  0000              add [eax],al
00004D36  0000              add [eax],al
00004D38  0000              add [eax],al
00004D3A  0000              add [eax],al
00004D3C  0000              add [eax],al
00004D3E  0000              add [eax],al
00004D40  0000              add [eax],al
00004D42  0000              add [eax],al
00004D44  0000              add [eax],al
00004D46  0000              add [eax],al
00004D48  0000              add [eax],al
00004D4A  0000              add [eax],al
00004D4C  0000              add [eax],al
00004D4E  0000              add [eax],al
00004D50  0000              add [eax],al
00004D52  0000              add [eax],al
00004D54  0000              add [eax],al
00004D56  0000              add [eax],al
00004D58  0000              add [eax],al
00004D5A  0000              add [eax],al
00004D5C  0000              add [eax],al
00004D5E  0000              add [eax],al
00004D60  0000              add [eax],al
00004D62  0000              add [eax],al
00004D64  0000              add [eax],al
00004D66  0000              add [eax],al
00004D68  0000              add [eax],al
00004D6A  0000              add [eax],al
00004D6C  0000              add [eax],al
00004D6E  0000              add [eax],al
00004D70  0000              add [eax],al
00004D72  0000              add [eax],al
00004D74  0000              add [eax],al
00004D76  0000              add [eax],al
00004D78  0000              add [eax],al
00004D7A  0000              add [eax],al
00004D7C  0000              add [eax],al
00004D7E  0000              add [eax],al
00004D80  0000              add [eax],al
00004D82  0000              add [eax],al
00004D84  0000              add [eax],al
00004D86  0000              add [eax],al
00004D88  0000              add [eax],al
00004D8A  0000              add [eax],al
00004D8C  0000              add [eax],al
00004D8E  0000              add [eax],al
00004D90  0000              add [eax],al
00004D92  0000              add [eax],al
00004D94  0000              add [eax],al
00004D96  0000              add [eax],al
00004D98  0000              add [eax],al
00004D9A  0000              add [eax],al
00004D9C  0000              add [eax],al
00004D9E  0000              add [eax],al
00004DA0  0000              add [eax],al
00004DA2  0000              add [eax],al
00004DA4  0000              add [eax],al
00004DA6  0000              add [eax],al
00004DA8  0000              add [eax],al
00004DAA  0000              add [eax],al
00004DAC  0000              add [eax],al
00004DAE  0000              add [eax],al
00004DB0  0000              add [eax],al
00004DB2  0000              add [eax],al
00004DB4  0000              add [eax],al
00004DB6  0000              add [eax],al
00004DB8  0000              add [eax],al
00004DBA  0000              add [eax],al
00004DBC  0000              add [eax],al
00004DBE  0000              add [eax],al
00004DC0  0000              add [eax],al
00004DC2  0000              add [eax],al
00004DC4  0000              add [eax],al
00004DC6  0000              add [eax],al
00004DC8  0000              add [eax],al
00004DCA  0000              add [eax],al
00004DCC  0000              add [eax],al
00004DCE  0000              add [eax],al
00004DD0  0000              add [eax],al
00004DD2  0000              add [eax],al
00004DD4  0000              add [eax],al
00004DD6  0000              add [eax],al
00004DD8  0000              add [eax],al
00004DDA  0000              add [eax],al
00004DDC  0000              add [eax],al
00004DDE  0000              add [eax],al
00004DE0  0000              add [eax],al
00004DE2  0000              add [eax],al
00004DE4  0000              add [eax],al
00004DE6  0000              add [eax],al
00004DE8  0000              add [eax],al
00004DEA  0000              add [eax],al
00004DEC  0000              add [eax],al
00004DEE  0000              add [eax],al
00004DF0  0000              add [eax],al
00004DF2  0000              add [eax],al
00004DF4  0000              add [eax],al
00004DF6  0000              add [eax],al
00004DF8  0000              add [eax],al
00004DFA  0000              add [eax],al
00004DFC  0000              add [eax],al
00004DFE  0000              add [eax],al
00004E00  0000              add [eax],al
00004E02  0000              add [eax],al
00004E04  0000              add [eax],al
00004E06  0000              add [eax],al
00004E08  0000              add [eax],al
00004E0A  0000              add [eax],al
00004E0C  0000              add [eax],al
00004E0E  0000              add [eax],al
00004E10  0000              add [eax],al
00004E12  0000              add [eax],al
00004E14  0000              add [eax],al
00004E16  0000              add [eax],al
00004E18  0000              add [eax],al
00004E1A  0000              add [eax],al
00004E1C  0000              add [eax],al
00004E1E  0000              add [eax],al
00004E20  0000              add [eax],al
00004E22  0000              add [eax],al
00004E24  0000              add [eax],al
00004E26  0000              add [eax],al
00004E28  0000              add [eax],al
00004E2A  0000              add [eax],al
00004E2C  0000              add [eax],al
00004E2E  0000              add [eax],al
00004E30  0000              add [eax],al
00004E32  0000              add [eax],al
00004E34  0000              add [eax],al
00004E36  0000              add [eax],al
00004E38  0000              add [eax],al
00004E3A  0000              add [eax],al
00004E3C  0000              add [eax],al
00004E3E  0000              add [eax],al
00004E40  0000              add [eax],al
00004E42  0000              add [eax],al
00004E44  0000              add [eax],al
00004E46  0000              add [eax],al
00004E48  0000              add [eax],al
00004E4A  0000              add [eax],al
00004E4C  0000              add [eax],al
00004E4E  0000              add [eax],al
00004E50  0000              add [eax],al
00004E52  0000              add [eax],al
00004E54  0000              add [eax],al
00004E56  0000              add [eax],al
00004E58  0000              add [eax],al
00004E5A  0000              add [eax],al
00004E5C  0000              add [eax],al
00004E5E  0000              add [eax],al
00004E60  0000              add [eax],al
00004E62  0000              add [eax],al
00004E64  0000              add [eax],al
00004E66  0000              add [eax],al
00004E68  0000              add [eax],al
00004E6A  0000              add [eax],al
00004E6C  0000              add [eax],al
00004E6E  0000              add [eax],al
00004E70  0000              add [eax],al
00004E72  0000              add [eax],al
00004E74  0000              add [eax],al
00004E76  0000              add [eax],al
00004E78  0000              add [eax],al
00004E7A  0000              add [eax],al
00004E7C  0000              add [eax],al
00004E7E  0000              add [eax],al
00004E80  0000              add [eax],al
00004E82  0000              add [eax],al
00004E84  0000              add [eax],al
00004E86  0000              add [eax],al
00004E88  0000              add [eax],al
00004E8A  0000              add [eax],al
00004E8C  0000              add [eax],al
00004E8E  0000              add [eax],al
00004E90  0000              add [eax],al
00004E92  0000              add [eax],al
00004E94  0000              add [eax],al
00004E96  0000              add [eax],al
00004E98  0000              add [eax],al
00004E9A  0000              add [eax],al
00004E9C  0000              add [eax],al
00004E9E  0000              add [eax],al
00004EA0  0000              add [eax],al
00004EA2  0000              add [eax],al
00004EA4  0000              add [eax],al
00004EA6  0000              add [eax],al
00004EA8  0000              add [eax],al
00004EAA  0000              add [eax],al
00004EAC  0000              add [eax],al
00004EAE  0000              add [eax],al
00004EB0  0000              add [eax],al
00004EB2  0000              add [eax],al
00004EB4  0000              add [eax],al
00004EB6  0000              add [eax],al
00004EB8  0000              add [eax],al
00004EBA  0000              add [eax],al
00004EBC  0000              add [eax],al
00004EBE  0000              add [eax],al
00004EC0  0000              add [eax],al
00004EC2  0000              add [eax],al
00004EC4  0000              add [eax],al
00004EC6  0000              add [eax],al
00004EC8  0000              add [eax],al
00004ECA  0000              add [eax],al
00004ECC  0000              add [eax],al
00004ECE  0000              add [eax],al
00004ED0  0000              add [eax],al
00004ED2  0000              add [eax],al
00004ED4  0000              add [eax],al
00004ED6  0000              add [eax],al
00004ED8  0000              add [eax],al
00004EDA  0000              add [eax],al
00004EDC  0000              add [eax],al
00004EDE  0000              add [eax],al
00004EE0  0000              add [eax],al
00004EE2  0000              add [eax],al
00004EE4  0000              add [eax],al
00004EE6  0000              add [eax],al
00004EE8  0000              add [eax],al
00004EEA  0000              add [eax],al
00004EEC  0000              add [eax],al
00004EEE  0000              add [eax],al
00004EF0  0000              add [eax],al
00004EF2  0000              add [eax],al
00004EF4  0000              add [eax],al
00004EF6  0000              add [eax],al
00004EF8  0000              add [eax],al
00004EFA  0000              add [eax],al
00004EFC  0000              add [eax],al
00004EFE  0000              add [eax],al
00004F00  0000              add [eax],al
00004F02  0000              add [eax],al
00004F04  0000              add [eax],al
00004F06  0000              add [eax],al
00004F08  0000              add [eax],al
00004F0A  0000              add [eax],al
00004F0C  0000              add [eax],al
00004F0E  0000              add [eax],al
00004F10  0000              add [eax],al
00004F12  0000              add [eax],al
00004F14  0000              add [eax],al
00004F16  0000              add [eax],al
00004F18  0000              add [eax],al
00004F1A  0000              add [eax],al
00004F1C  0000              add [eax],al
00004F1E  0000              add [eax],al
00004F20  0000              add [eax],al
00004F22  0000              add [eax],al
00004F24  0000              add [eax],al
00004F26  0000              add [eax],al
00004F28  0000              add [eax],al
00004F2A  0000              add [eax],al
00004F2C  0000              add [eax],al
00004F2E  0000              add [eax],al
00004F30  0000              add [eax],al
00004F32  0000              add [eax],al
00004F34  0000              add [eax],al
00004F36  0000              add [eax],al
00004F38  0000              add [eax],al
00004F3A  0000              add [eax],al
00004F3C  0000              add [eax],al
00004F3E  0000              add [eax],al
00004F40  0000              add [eax],al
00004F42  0000              add [eax],al
00004F44  0000              add [eax],al
00004F46  0000              add [eax],al
00004F48  0000              add [eax],al
00004F4A  0000              add [eax],al
00004F4C  0000              add [eax],al
00004F4E  0000              add [eax],al
00004F50  0000              add [eax],al
00004F52  0000              add [eax],al
00004F54  0000              add [eax],al
00004F56  0000              add [eax],al
00004F58  0000              add [eax],al
00004F5A  0000              add [eax],al
00004F5C  0000              add [eax],al
00004F5E  0000              add [eax],al
00004F60  0000              add [eax],al
00004F62  0000              add [eax],al
00004F64  0000              add [eax],al
00004F66  0000              add [eax],al
00004F68  0000              add [eax],al
00004F6A  0000              add [eax],al
00004F6C  0000              add [eax],al
00004F6E  0000              add [eax],al
00004F70  0000              add [eax],al
00004F72  0000              add [eax],al
00004F74  0000              add [eax],al
00004F76  0000              add [eax],al
00004F78  0000              add [eax],al
00004F7A  0000              add [eax],al
00004F7C  0000              add [eax],al
00004F7E  0000              add [eax],al
00004F80  0000              add [eax],al
00004F82  0000              add [eax],al
00004F84  0000              add [eax],al
00004F86  0000              add [eax],al
00004F88  0000              add [eax],al
00004F8A  0000              add [eax],al
00004F8C  0000              add [eax],al
00004F8E  0000              add [eax],al
00004F90  0000              add [eax],al
00004F92  0000              add [eax],al
00004F94  0000              add [eax],al
00004F96  0000              add [eax],al
00004F98  0000              add [eax],al
00004F9A  0000              add [eax],al
00004F9C  0000              add [eax],al
00004F9E  0000              add [eax],al
00004FA0  0000              add [eax],al
00004FA2  0000              add [eax],al
00004FA4  0000              add [eax],al
00004FA6  0000              add [eax],al
00004FA8  0000              add [eax],al
00004FAA  0000              add [eax],al
00004FAC  0000              add [eax],al
00004FAE  0000              add [eax],al
00004FB0  0000              add [eax],al
00004FB2  0000              add [eax],al
00004FB4  0000              add [eax],al
00004FB6  0000              add [eax],al
00004FB8  0000              add [eax],al
00004FBA  0000              add [eax],al
00004FBC  0000              add [eax],al
00004FBE  0000              add [eax],al
00004FC0  0000              add [eax],al
00004FC2  0000              add [eax],al
00004FC4  0000              add [eax],al
00004FC6  0000              add [eax],al
00004FC8  0000              add [eax],al
00004FCA  0000              add [eax],al
00004FCC  0000              add [eax],al
00004FCE  0000              add [eax],al
00004FD0  0000              add [eax],al
00004FD2  0000              add [eax],al
00004FD4  0000              add [eax],al
00004FD6  0000              add [eax],al
00004FD8  0000              add [eax],al
00004FDA  0000              add [eax],al
00004FDC  0000              add [eax],al
00004FDE  0000              add [eax],al
00004FE0  0000              add [eax],al
00004FE2  0000              add [eax],al
00004FE4  0000              add [eax],al
00004FE6  0000              add [eax],al
00004FE8  0000              add [eax],al
00004FEA  0000              add [eax],al
00004FEC  0000              add [eax],al
00004FEE  0000              add [eax],al
00004FF0  0000              add [eax],al
00004FF2  0000              add [eax],al
00004FF4  0000              add [eax],al
00004FF6  0000              add [eax],al
00004FF8  0000              add [eax],al
00004FFA  0000              add [eax],al
00004FFC  0000              add [eax],al
00004FFE  0000              add [eax],al
00005000  0000              add [eax],al
00005002  0000              add [eax],al
00005004  0000              add [eax],al
00005006  0000              add [eax],al
00005008  0000              add [eax],al
0000500A  0000              add [eax],al
0000500C  0000              add [eax],al
0000500E  0000              add [eax],al
00005010  0000              add [eax],al
00005012  0000              add [eax],al
00005014  0000              add [eax],al
00005016  0000              add [eax],al
00005018  0000              add [eax],al
0000501A  0000              add [eax],al
0000501C  0000              add [eax],al
0000501E  0000              add [eax],al
00005020  0000              add [eax],al
00005022  0000              add [eax],al
00005024  0000              add [eax],al
00005026  0000              add [eax],al
00005028  0000              add [eax],al
0000502A  0000              add [eax],al
0000502C  0000              add [eax],al
0000502E  0000              add [eax],al
00005030  0000              add [eax],al
00005032  0000              add [eax],al
00005034  0000              add [eax],al
00005036  0000              add [eax],al
00005038  0000              add [eax],al
0000503A  0000              add [eax],al
0000503C  0000              add [eax],al
0000503E  0000              add [eax],al
00005040  0000              add [eax],al
00005042  0000              add [eax],al
00005044  0000              add [eax],al
00005046  0000              add [eax],al
00005048  0000              add [eax],al
0000504A  0000              add [eax],al
0000504C  0000              add [eax],al
0000504E  0000              add [eax],al
00005050  0000              add [eax],al
00005052  0000              add [eax],al
00005054  0000              add [eax],al
00005056  0000              add [eax],al
00005058  0000              add [eax],al
0000505A  0000              add [eax],al
0000505C  0000              add [eax],al
0000505E  0000              add [eax],al
00005060  0000              add [eax],al
00005062  0000              add [eax],al
00005064  0000              add [eax],al
00005066  0000              add [eax],al
00005068  0000              add [eax],al
0000506A  0000              add [eax],al
0000506C  0000              add [eax],al
0000506E  0000              add [eax],al
00005070  0000              add [eax],al
00005072  0000              add [eax],al
00005074  0000              add [eax],al
00005076  0000              add [eax],al
00005078  0000              add [eax],al
0000507A  0000              add [eax],al
0000507C  0000              add [eax],al
0000507E  0000              add [eax],al
00005080  0000              add [eax],al
00005082  0000              add [eax],al
00005084  0000              add [eax],al
00005086  0000              add [eax],al
00005088  0000              add [eax],al
0000508A  0000              add [eax],al
0000508C  0000              add [eax],al
0000508E  0000              add [eax],al
00005090  0000              add [eax],al
00005092  0000              add [eax],al
00005094  0000              add [eax],al
00005096  0000              add [eax],al
00005098  0000              add [eax],al
0000509A  0000              add [eax],al
0000509C  0000              add [eax],al
0000509E  0000              add [eax],al
000050A0  0000              add [eax],al
000050A2  0000              add [eax],al
000050A4  0000              add [eax],al
000050A6  0000              add [eax],al
000050A8  0000              add [eax],al
000050AA  0000              add [eax],al
000050AC  0000              add [eax],al
000050AE  0000              add [eax],al
000050B0  0000              add [eax],al
000050B2  0000              add [eax],al
000050B4  0000              add [eax],al
000050B6  0000              add [eax],al
000050B8  0000              add [eax],al
000050BA  0000              add [eax],al
000050BC  0000              add [eax],al
000050BE  0000              add [eax],al
000050C0  0000              add [eax],al
000050C2  0000              add [eax],al
000050C4  0000              add [eax],al
000050C6  0000              add [eax],al
000050C8  0000              add [eax],al
000050CA  0000              add [eax],al
000050CC  0000              add [eax],al
000050CE  0000              add [eax],al
000050D0  0000              add [eax],al
000050D2  0000              add [eax],al
000050D4  0000              add [eax],al
000050D6  0000              add [eax],al
000050D8  0000              add [eax],al
000050DA  0000              add [eax],al
000050DC  0000              add [eax],al
000050DE  0000              add [eax],al
000050E0  0000              add [eax],al
000050E2  0000              add [eax],al
000050E4  0000              add [eax],al
000050E6  0000              add [eax],al
000050E8  0000              add [eax],al
000050EA  0000              add [eax],al
000050EC  0000              add [eax],al
000050EE  0000              add [eax],al
000050F0  0000              add [eax],al
000050F2  0000              add [eax],al
000050F4  0000              add [eax],al
000050F6  0000              add [eax],al
000050F8  0000              add [eax],al
000050FA  0000              add [eax],al
000050FC  0000              add [eax],al
000050FE  0000              add [eax],al
00005100  0000              add [eax],al
00005102  0000              add [eax],al
00005104  0000              add [eax],al
00005106  0000              add [eax],al
00005108  0000              add [eax],al
0000510A  0000              add [eax],al
0000510C  0000              add [eax],al
0000510E  0000              add [eax],al
00005110  0000              add [eax],al
00005112  0000              add [eax],al
00005114  0000              add [eax],al
00005116  0000              add [eax],al
00005118  0000              add [eax],al
0000511A  0000              add [eax],al
0000511C  0000              add [eax],al
0000511E  0000              add [eax],al
00005120  0000              add [eax],al
00005122  0000              add [eax],al
00005124  0000              add [eax],al
00005126  0000              add [eax],al
00005128  0000              add [eax],al
0000512A  0000              add [eax],al
0000512C  0000              add [eax],al
0000512E  0000              add [eax],al
00005130  0000              add [eax],al
00005132  0000              add [eax],al
00005134  0000              add [eax],al
00005136  0000              add [eax],al
00005138  0000              add [eax],al
0000513A  0000              add [eax],al
0000513C  0000              add [eax],al
0000513E  0000              add [eax],al
00005140  0000              add [eax],al
00005142  0000              add [eax],al
00005144  0000              add [eax],al
00005146  0000              add [eax],al
00005148  0000              add [eax],al
0000514A  0000              add [eax],al
0000514C  0000              add [eax],al
0000514E  0000              add [eax],al
00005150  0000              add [eax],al
00005152  0000              add [eax],al
00005154  0000              add [eax],al
00005156  0000              add [eax],al
00005158  0000              add [eax],al
0000515A  0000              add [eax],al
0000515C  0000              add [eax],al
0000515E  0000              add [eax],al
00005160  0000              add [eax],al
00005162  0000              add [eax],al
00005164  0000              add [eax],al
00005166  0000              add [eax],al
00005168  0000              add [eax],al
0000516A  0000              add [eax],al
0000516C  0000              add [eax],al
0000516E  0000              add [eax],al
00005170  0000              add [eax],al
00005172  0000              add [eax],al
00005174  0000              add [eax],al
00005176  0000              add [eax],al
00005178  0000              add [eax],al
0000517A  0000              add [eax],al
0000517C  0000              add [eax],al
0000517E  0000              add [eax],al
00005180  0000              add [eax],al
00005182  0000              add [eax],al
00005184  0000              add [eax],al
00005186  0000              add [eax],al
00005188  0000              add [eax],al
0000518A  0000              add [eax],al
0000518C  0000              add [eax],al
0000518E  0000              add [eax],al
00005190  0000              add [eax],al
00005192  0000              add [eax],al
00005194  0000              add [eax],al
00005196  0000              add [eax],al
00005198  0000              add [eax],al
0000519A  0000              add [eax],al
0000519C  0000              add [eax],al
0000519E  0000              add [eax],al
000051A0  0000              add [eax],al
000051A2  0000              add [eax],al
000051A4  0000              add [eax],al
000051A6  0000              add [eax],al
000051A8  0000              add [eax],al
000051AA  0000              add [eax],al
000051AC  0000              add [eax],al
000051AE  0000              add [eax],al
000051B0  0000              add [eax],al
000051B2  0000              add [eax],al
000051B4  0000              add [eax],al
000051B6  0000              add [eax],al
000051B8  0000              add [eax],al
000051BA  0000              add [eax],al
000051BC  0000              add [eax],al
000051BE  0000              add [eax],al
000051C0  0000              add [eax],al
000051C2  0000              add [eax],al
000051C4  0000              add [eax],al
000051C6  0000              add [eax],al
000051C8  0000              add [eax],al
000051CA  0000              add [eax],al
000051CC  0000              add [eax],al
000051CE  0000              add [eax],al
000051D0  0000              add [eax],al
000051D2  0000              add [eax],al
000051D4  0000              add [eax],al
000051D6  0000              add [eax],al
000051D8  0000              add [eax],al
000051DA  0000              add [eax],al
000051DC  0000              add [eax],al
000051DE  0000              add [eax],al
000051E0  0000              add [eax],al
000051E2  0000              add [eax],al
000051E4  0000              add [eax],al
000051E6  0000              add [eax],al
000051E8  0000              add [eax],al
000051EA  0000              add [eax],al
000051EC  0000              add [eax],al
000051EE  0000              add [eax],al
000051F0  0000              add [eax],al
000051F2  0000              add [eax],al
000051F4  0000              add [eax],al
000051F6  0000              add [eax],al
000051F8  0000              add [eax],al
000051FA  0000              add [eax],al
000051FC  0000              add [eax],al
000051FE  0000              add [eax],al
00005200  0000              add [eax],al
00005202  0000              add [eax],al
00005204  0000              add [eax],al
00005206  0000              add [eax],al
00005208  0000              add [eax],al
0000520A  0000              add [eax],al
0000520C  0000              add [eax],al
0000520E  0000              add [eax],al
00005210  0000              add [eax],al
00005212  0000              add [eax],al
00005214  0000              add [eax],al
00005216  0000              add [eax],al
00005218  0000              add [eax],al
0000521A  0000              add [eax],al
0000521C  0000              add [eax],al
0000521E  0000              add [eax],al
00005220  0000              add [eax],al
00005222  0000              add [eax],al
00005224  0000              add [eax],al
00005226  0000              add [eax],al
00005228  0000              add [eax],al
0000522A  0000              add [eax],al
0000522C  0000              add [eax],al
0000522E  0000              add [eax],al
00005230  0000              add [eax],al
00005232  0000              add [eax],al
00005234  0000              add [eax],al
00005236  0000              add [eax],al
00005238  0000              add [eax],al
0000523A  0000              add [eax],al
0000523C  0000              add [eax],al
0000523E  0000              add [eax],al
00005240  0000              add [eax],al
00005242  0000              add [eax],al
00005244  0000              add [eax],al
00005246  0000              add [eax],al
00005248  0000              add [eax],al
0000524A  0000              add [eax],al
0000524C  0000              add [eax],al
0000524E  0000              add [eax],al
00005250  0000              add [eax],al
00005252  0000              add [eax],al
00005254  0000              add [eax],al
00005256  0000              add [eax],al
00005258  0000              add [eax],al
0000525A  0000              add [eax],al
0000525C  0000              add [eax],al
0000525E  0000              add [eax],al
00005260  0000              add [eax],al
00005262  0000              add [eax],al
00005264  0000              add [eax],al
00005266  0000              add [eax],al
00005268  0000              add [eax],al
0000526A  0000              add [eax],al
0000526C  0000              add [eax],al
0000526E  0000              add [eax],al
00005270  0000              add [eax],al
00005272  0000              add [eax],al
00005274  0000              add [eax],al
00005276  0000              add [eax],al
00005278  0000              add [eax],al
0000527A  0000              add [eax],al
0000527C  0000              add [eax],al
0000527E  0000              add [eax],al
00005280  0000              add [eax],al
00005282  0000              add [eax],al
00005284  0000              add [eax],al
00005286  0000              add [eax],al
00005288  0000              add [eax],al
0000528A  0000              add [eax],al
0000528C  0000              add [eax],al
0000528E  0000              add [eax],al
00005290  0000              add [eax],al
00005292  0000              add [eax],al
00005294  0000              add [eax],al
00005296  0000              add [eax],al
00005298  0000              add [eax],al
0000529A  0000              add [eax],al
0000529C  0000              add [eax],al
0000529E  0000              add [eax],al
000052A0  0000              add [eax],al
000052A2  0000              add [eax],al
000052A4  0000              add [eax],al
000052A6  0000              add [eax],al
000052A8  0000              add [eax],al
000052AA  0000              add [eax],al
000052AC  0000              add [eax],al
000052AE  0000              add [eax],al
000052B0  0000              add [eax],al
000052B2  0000              add [eax],al
000052B4  0000              add [eax],al
000052B6  0000              add [eax],al
000052B8  0000              add [eax],al
000052BA  0000              add [eax],al
000052BC  0000              add [eax],al
000052BE  0000              add [eax],al
000052C0  0000              add [eax],al
000052C2  0000              add [eax],al
000052C4  0000              add [eax],al
000052C6  0000              add [eax],al
000052C8  0000              add [eax],al
000052CA  0000              add [eax],al
000052CC  0000              add [eax],al
000052CE  0000              add [eax],al
000052D0  0000              add [eax],al
000052D2  0000              add [eax],al
000052D4  0000              add [eax],al
000052D6  0000              add [eax],al
000052D8  0000              add [eax],al
000052DA  0000              add [eax],al
000052DC  0000              add [eax],al
000052DE  0000              add [eax],al
000052E0  0000              add [eax],al
000052E2  0000              add [eax],al
000052E4  0000              add [eax],al
000052E6  0000              add [eax],al
000052E8  0000              add [eax],al
000052EA  0000              add [eax],al
000052EC  0000              add [eax],al
000052EE  0000              add [eax],al
000052F0  0000              add [eax],al
000052F2  0000              add [eax],al
000052F4  0000              add [eax],al
000052F6  0000              add [eax],al
000052F8  0000              add [eax],al
000052FA  0000              add [eax],al
000052FC  0000              add [eax],al
000052FE  0000              add [eax],al
00005300  0000              add [eax],al
00005302  0000              add [eax],al
00005304  0000              add [eax],al
00005306  0000              add [eax],al
00005308  0000              add [eax],al
0000530A  0000              add [eax],al
0000530C  0000              add [eax],al
0000530E  0000              add [eax],al
00005310  0000              add [eax],al
00005312  0000              add [eax],al
00005314  0000              add [eax],al
00005316  0000              add [eax],al
00005318  0000              add [eax],al
0000531A  0000              add [eax],al
0000531C  0000              add [eax],al
0000531E  0000              add [eax],al
00005320  0000              add [eax],al
00005322  0000              add [eax],al
00005324  0000              add [eax],al
00005326  0000              add [eax],al
00005328  0000              add [eax],al
0000532A  0000              add [eax],al
0000532C  0000              add [eax],al
0000532E  0000              add [eax],al
00005330  0000              add [eax],al
00005332  0000              add [eax],al
00005334  0000              add [eax],al
00005336  0000              add [eax],al
00005338  0000              add [eax],al
0000533A  0000              add [eax],al
0000533C  0000              add [eax],al
0000533E  0000              add [eax],al
00005340  0000              add [eax],al
00005342  0000              add [eax],al
00005344  0000              add [eax],al
00005346  0000              add [eax],al
00005348  0000              add [eax],al
0000534A  0000              add [eax],al
0000534C  0000              add [eax],al
0000534E  0000              add [eax],al
00005350  0000              add [eax],al
00005352  0000              add [eax],al
00005354  0000              add [eax],al
00005356  0000              add [eax],al
00005358  0000              add [eax],al
0000535A  0000              add [eax],al
0000535C  0000              add [eax],al
0000535E  0000              add [eax],al
00005360  0000              add [eax],al
00005362  0000              add [eax],al
00005364  0000              add [eax],al
00005366  0000              add [eax],al
00005368  0000              add [eax],al
0000536A  0000              add [eax],al
0000536C  0000              add [eax],al
0000536E  0000              add [eax],al
00005370  0000              add [eax],al
00005372  0000              add [eax],al
00005374  0000              add [eax],al
00005376  0000              add [eax],al
00005378  0000              add [eax],al
0000537A  0000              add [eax],al
0000537C  0000              add [eax],al
0000537E  0000              add [eax],al
00005380  0000              add [eax],al
00005382  0000              add [eax],al
00005384  0000              add [eax],al
00005386  0000              add [eax],al
00005388  0000              add [eax],al
0000538A  0000              add [eax],al
0000538C  0000              add [eax],al
0000538E  0000              add [eax],al
00005390  0000              add [eax],al
00005392  0000              add [eax],al
00005394  0000              add [eax],al
00005396  0000              add [eax],al
00005398  0000              add [eax],al
0000539A  0000              add [eax],al
0000539C  0000              add [eax],al
0000539E  0000              add [eax],al
000053A0  0000              add [eax],al
000053A2  0000              add [eax],al
000053A4  0000              add [eax],al
000053A6  0000              add [eax],al
000053A8  0000              add [eax],al
000053AA  0000              add [eax],al
000053AC  0000              add [eax],al
000053AE  0000              add [eax],al
000053B0  0000              add [eax],al
000053B2  0000              add [eax],al
000053B4  0000              add [eax],al
000053B6  0000              add [eax],al
000053B8  0000              add [eax],al
000053BA  0000              add [eax],al
000053BC  0000              add [eax],al
000053BE  0000              add [eax],al
000053C0  0000              add [eax],al
000053C2  0000              add [eax],al
000053C4  0000              add [eax],al
000053C6  0000              add [eax],al
000053C8  0000              add [eax],al
000053CA  0000              add [eax],al
000053CC  0000              add [eax],al
000053CE  0000              add [eax],al
000053D0  0000              add [eax],al
000053D2  0000              add [eax],al
000053D4  0000              add [eax],al
000053D6  0000              add [eax],al
000053D8  0000              add [eax],al
000053DA  0000              add [eax],al
000053DC  0000              add [eax],al
000053DE  0000              add [eax],al
000053E0  0000              add [eax],al
000053E2  0000              add [eax],al
000053E4  0000              add [eax],al
000053E6  0000              add [eax],al
000053E8  0000              add [eax],al
000053EA  0000              add [eax],al
000053EC  0000              add [eax],al
000053EE  0000              add [eax],al
000053F0  0000              add [eax],al
000053F2  0000              add [eax],al
000053F4  0000              add [eax],al
000053F6  0000              add [eax],al
000053F8  0000              add [eax],al
000053FA  0000              add [eax],al
000053FC  0000              add [eax],al
000053FE  0000              add [eax],al
00005400  0000              add [eax],al
00005402  0000              add [eax],al
00005404  0000              add [eax],al
00005406  0000              add [eax],al
00005408  0000              add [eax],al
0000540A  0000              add [eax],al
0000540C  0000              add [eax],al
0000540E  0000              add [eax],al
00005410  0000              add [eax],al
00005412  0000              add [eax],al
00005414  0000              add [eax],al
00005416  0000              add [eax],al
00005418  0000              add [eax],al
0000541A  0000              add [eax],al
0000541C  0000              add [eax],al
0000541E  0000              add [eax],al
00005420  0000              add [eax],al
00005422  0000              add [eax],al
00005424  0000              add [eax],al
00005426  0000              add [eax],al
00005428  0000              add [eax],al
0000542A  0000              add [eax],al
0000542C  0000              add [eax],al
0000542E  0000              add [eax],al
00005430  0000              add [eax],al
00005432  0000              add [eax],al
00005434  0000              add [eax],al
00005436  0000              add [eax],al
00005438  0000              add [eax],al
0000543A  0000              add [eax],al
0000543C  0000              add [eax],al
0000543E  0000              add [eax],al
00005440  0000              add [eax],al
00005442  0000              add [eax],al
00005444  0000              add [eax],al
00005446  0000              add [eax],al
00005448  0000              add [eax],al
0000544A  0000              add [eax],al
0000544C  0000              add [eax],al
0000544E  0000              add [eax],al
00005450  0000              add [eax],al
00005452  0000              add [eax],al
00005454  0000              add [eax],al
00005456  0000              add [eax],al
00005458  0000              add [eax],al
0000545A  0000              add [eax],al
0000545C  0000              add [eax],al
0000545E  0000              add [eax],al
00005460  0000              add [eax],al
00005462  0000              add [eax],al
00005464  0000              add [eax],al
00005466  0000              add [eax],al
00005468  0000              add [eax],al
0000546A  0000              add [eax],al
0000546C  0000              add [eax],al
0000546E  0000              add [eax],al
00005470  0000              add [eax],al
00005472  0000              add [eax],al
00005474  0000              add [eax],al
00005476  0000              add [eax],al
00005478  0000              add [eax],al
0000547A  0000              add [eax],al
0000547C  0000              add [eax],al
0000547E  0000              add [eax],al
00005480  0000              add [eax],al
00005482  0000              add [eax],al
00005484  0000              add [eax],al
00005486  0000              add [eax],al
00005488  0000              add [eax],al
0000548A  0000              add [eax],al
0000548C  0000              add [eax],al
0000548E  0000              add [eax],al
00005490  0000              add [eax],al
00005492  0000              add [eax],al
00005494  0000              add [eax],al
00005496  0000              add [eax],al
00005498  0000              add [eax],al
0000549A  0000              add [eax],al
0000549C  0000              add [eax],al
0000549E  0000              add [eax],al
000054A0  0000              add [eax],al
000054A2  0000              add [eax],al
000054A4  0000              add [eax],al
000054A6  0000              add [eax],al
000054A8  0000              add [eax],al
000054AA  0000              add [eax],al
000054AC  0000              add [eax],al
000054AE  0000              add [eax],al
000054B0  0000              add [eax],al
000054B2  0000              add [eax],al
000054B4  0000              add [eax],al
000054B6  0000              add [eax],al
000054B8  0000              add [eax],al
000054BA  0000              add [eax],al
000054BC  0000              add [eax],al
000054BE  0000              add [eax],al
000054C0  0000              add [eax],al
000054C2  0000              add [eax],al
000054C4  0000              add [eax],al
000054C6  0000              add [eax],al
000054C8  0000              add [eax],al
000054CA  0000              add [eax],al
000054CC  0000              add [eax],al
000054CE  0000              add [eax],al
000054D0  0000              add [eax],al
000054D2  0000              add [eax],al
000054D4  0000              add [eax],al
000054D6  0000              add [eax],al
000054D8  0000              add [eax],al
000054DA  0000              add [eax],al
000054DC  0000              add [eax],al
000054DE  0000              add [eax],al
000054E0  0000              add [eax],al
000054E2  0000              add [eax],al
000054E4  0000              add [eax],al
000054E6  0000              add [eax],al
000054E8  0000              add [eax],al
000054EA  0000              add [eax],al
000054EC  0000              add [eax],al
000054EE  0000              add [eax],al
000054F0  0000              add [eax],al
000054F2  0000              add [eax],al
000054F4  0000              add [eax],al
000054F6  0000              add [eax],al
000054F8  0000              add [eax],al
000054FA  0000              add [eax],al
000054FC  0000              add [eax],al
000054FE  0000              add [eax],al
00005500  0000              add [eax],al
00005502  0000              add [eax],al
00005504  0000              add [eax],al
00005506  0000              add [eax],al
00005508  0000              add [eax],al
0000550A  0000              add [eax],al
0000550C  0000              add [eax],al
0000550E  0000              add [eax],al
00005510  0000              add [eax],al
00005512  0000              add [eax],al
00005514  0000              add [eax],al
00005516  0000              add [eax],al
00005518  0000              add [eax],al
0000551A  0000              add [eax],al
0000551C  0000              add [eax],al
0000551E  0000              add [eax],al
00005520  0000              add [eax],al
00005522  0000              add [eax],al
00005524  0000              add [eax],al
00005526  0000              add [eax],al
00005528  0000              add [eax],al
0000552A  0000              add [eax],al
0000552C  0000              add [eax],al
0000552E  0000              add [eax],al
00005530  0000              add [eax],al
00005532  0000              add [eax],al
00005534  0000              add [eax],al
00005536  0000              add [eax],al
00005538  0000              add [eax],al
0000553A  0000              add [eax],al
0000553C  0000              add [eax],al
0000553E  0000              add [eax],al
00005540  0000              add [eax],al
00005542  0000              add [eax],al
00005544  0000              add [eax],al
00005546  0000              add [eax],al
00005548  0000              add [eax],al
0000554A  0000              add [eax],al
0000554C  0000              add [eax],al
0000554E  0000              add [eax],al
00005550  0000              add [eax],al
00005552  0000              add [eax],al
00005554  0000              add [eax],al
00005556  0000              add [eax],al
00005558  0000              add [eax],al
0000555A  0000              add [eax],al
0000555C  0000              add [eax],al
0000555E  0000              add [eax],al
00005560  0000              add [eax],al
00005562  0000              add [eax],al
00005564  0000              add [eax],al
00005566  0000              add [eax],al
00005568  0000              add [eax],al
0000556A  0000              add [eax],al
0000556C  0000              add [eax],al
0000556E  0000              add [eax],al
00005570  0000              add [eax],al
00005572  0000              add [eax],al
00005574  0000              add [eax],al
00005576  0000              add [eax],al
00005578  0000              add [eax],al
0000557A  0000              add [eax],al
0000557C  0000              add [eax],al
0000557E  0000              add [eax],al
00005580  0000              add [eax],al
00005582  0000              add [eax],al
00005584  0000              add [eax],al
00005586  0000              add [eax],al
00005588  0000              add [eax],al
0000558A  0000              add [eax],al
0000558C  0000              add [eax],al
0000558E  0000              add [eax],al
00005590  0000              add [eax],al
00005592  0000              add [eax],al
00005594  0000              add [eax],al
00005596  0000              add [eax],al
00005598  0000              add [eax],al
0000559A  0000              add [eax],al
0000559C  0000              add [eax],al
0000559E  0000              add [eax],al
000055A0  0000              add [eax],al
000055A2  0000              add [eax],al
000055A4  0000              add [eax],al
000055A6  0000              add [eax],al
000055A8  0000              add [eax],al
000055AA  0000              add [eax],al
000055AC  0000              add [eax],al
000055AE  0000              add [eax],al
000055B0  0000              add [eax],al
000055B2  0000              add [eax],al
000055B4  0000              add [eax],al
000055B6  0000              add [eax],al
000055B8  0000              add [eax],al
000055BA  0000              add [eax],al
000055BC  0000              add [eax],al
000055BE  0000              add [eax],al
000055C0  0000              add [eax],al
000055C2  0000              add [eax],al
000055C4  0000              add [eax],al
000055C6  0000              add [eax],al
000055C8  0000              add [eax],al
000055CA  0000              add [eax],al
000055CC  0000              add [eax],al
000055CE  0000              add [eax],al
000055D0  0000              add [eax],al
000055D2  0000              add [eax],al
000055D4  0000              add [eax],al
000055D6  0000              add [eax],al
000055D8  0000              add [eax],al
000055DA  0000              add [eax],al
000055DC  0000              add [eax],al
000055DE  0000              add [eax],al
000055E0  0000              add [eax],al
000055E2  0000              add [eax],al
000055E4  0000              add [eax],al
000055E6  0000              add [eax],al
000055E8  0000              add [eax],al
000055EA  0000              add [eax],al
000055EC  0000              add [eax],al
000055EE  0000              add [eax],al
000055F0  0000              add [eax],al
000055F2  0000              add [eax],al
000055F4  0000              add [eax],al
000055F6  0000              add [eax],al
000055F8  0000              add [eax],al
000055FA  0000              add [eax],al
000055FC  0000              add [eax],al
000055FE  0000              add [eax],al
00005600  0000              add [eax],al
00005602  0000              add [eax],al
00005604  0000              add [eax],al
00005606  0000              add [eax],al
00005608  0000              add [eax],al
0000560A  0000              add [eax],al
0000560C  0000              add [eax],al
0000560E  0000              add [eax],al
00005610  0000              add [eax],al
00005612  0000              add [eax],al
00005614  0000              add [eax],al
00005616  0000              add [eax],al
00005618  0000              add [eax],al
0000561A  0000              add [eax],al
0000561C  0000              add [eax],al
0000561E  0000              add [eax],al
00005620  0000              add [eax],al
00005622  0000              add [eax],al
00005624  0000              add [eax],al
00005626  0000              add [eax],al
00005628  0000              add [eax],al
0000562A  0000              add [eax],al
0000562C  0000              add [eax],al
0000562E  0000              add [eax],al
00005630  0000              add [eax],al
00005632  0000              add [eax],al
00005634  0000              add [eax],al
00005636  0000              add [eax],al
00005638  0000              add [eax],al
0000563A  0000              add [eax],al
0000563C  0000              add [eax],al
0000563E  0000              add [eax],al
00005640  0000              add [eax],al
00005642  0000              add [eax],al
00005644  0000              add [eax],al
00005646  0000              add [eax],al
00005648  0000              add [eax],al
0000564A  0000              add [eax],al
0000564C  0000              add [eax],al
0000564E  0000              add [eax],al
00005650  0000              add [eax],al
00005652  0000              add [eax],al
00005654  0000              add [eax],al
00005656  0000              add [eax],al
00005658  0000              add [eax],al
0000565A  0000              add [eax],al
0000565C  0000              add [eax],al
0000565E  0000              add [eax],al
00005660  0000              add [eax],al
00005662  0000              add [eax],al
00005664  0000              add [eax],al
00005666  0000              add [eax],al
00005668  0000              add [eax],al
0000566A  0000              add [eax],al
0000566C  0000              add [eax],al
0000566E  0000              add [eax],al
00005670  0000              add [eax],al
00005672  0000              add [eax],al
00005674  0000              add [eax],al
00005676  0000              add [eax],al
00005678  0000              add [eax],al
0000567A  0000              add [eax],al
0000567C  0000              add [eax],al
0000567E  0000              add [eax],al
00005680  0000              add [eax],al
00005682  0000              add [eax],al
00005684  0000              add [eax],al
00005686  0000              add [eax],al
00005688  0000              add [eax],al
0000568A  0000              add [eax],al
0000568C  0000              add [eax],al
0000568E  0000              add [eax],al
00005690  0000              add [eax],al
00005692  0000              add [eax],al
00005694  0000              add [eax],al
00005696  0000              add [eax],al
00005698  0000              add [eax],al
0000569A  0000              add [eax],al
0000569C  0000              add [eax],al
0000569E  0000              add [eax],al
000056A0  0000              add [eax],al
000056A2  0000              add [eax],al
000056A4  0000              add [eax],al
000056A6  0000              add [eax],al
000056A8  0000              add [eax],al
000056AA  0000              add [eax],al
000056AC  0000              add [eax],al
000056AE  0000              add [eax],al
000056B0  0000              add [eax],al
000056B2  0000              add [eax],al
000056B4  0000              add [eax],al
000056B6  0000              add [eax],al
000056B8  0000              add [eax],al
000056BA  0000              add [eax],al
000056BC  0000              add [eax],al
000056BE  0000              add [eax],al
000056C0  0000              add [eax],al
000056C2  0000              add [eax],al
000056C4  0000              add [eax],al
000056C6  0000              add [eax],al
000056C8  0000              add [eax],al
000056CA  0000              add [eax],al
000056CC  0000              add [eax],al
000056CE  0000              add [eax],al
000056D0  0000              add [eax],al
000056D2  0000              add [eax],al
000056D4  0000              add [eax],al
000056D6  0000              add [eax],al
000056D8  0000              add [eax],al
000056DA  0000              add [eax],al
000056DC  0000              add [eax],al
000056DE  0000              add [eax],al
000056E0  0000              add [eax],al
000056E2  0000              add [eax],al
000056E4  0000              add [eax],al
000056E6  0000              add [eax],al
000056E8  0000              add [eax],al
000056EA  0000              add [eax],al
000056EC  0000              add [eax],al
000056EE  0000              add [eax],al
000056F0  0000              add [eax],al
000056F2  0000              add [eax],al
000056F4  0000              add [eax],al
000056F6  0000              add [eax],al
000056F8  0000              add [eax],al
000056FA  0000              add [eax],al
000056FC  0000              add [eax],al
000056FE  0000              add [eax],al
00005700  0000              add [eax],al
00005702  0000              add [eax],al
00005704  0000              add [eax],al
00005706  0000              add [eax],al
00005708  0000              add [eax],al
0000570A  0000              add [eax],al
0000570C  0000              add [eax],al
0000570E  0000              add [eax],al
00005710  0000              add [eax],al
00005712  0000              add [eax],al
00005714  0000              add [eax],al
00005716  0000              add [eax],al
00005718  0000              add [eax],al
0000571A  0000              add [eax],al
0000571C  0000              add [eax],al
0000571E  0000              add [eax],al
00005720  0000              add [eax],al
00005722  0000              add [eax],al
00005724  0000              add [eax],al
00005726  0000              add [eax],al
00005728  0000              add [eax],al
0000572A  0000              add [eax],al
0000572C  0000              add [eax],al
0000572E  0000              add [eax],al
00005730  0000              add [eax],al
00005732  0000              add [eax],al
00005734  0000              add [eax],al
00005736  0000              add [eax],al
00005738  0000              add [eax],al
0000573A  0000              add [eax],al
0000573C  0000              add [eax],al
0000573E  0000              add [eax],al
00005740  0000              add [eax],al
00005742  0000              add [eax],al
00005744  0000              add [eax],al
00005746  0000              add [eax],al
00005748  0000              add [eax],al
0000574A  0000              add [eax],al
0000574C  0000              add [eax],al
0000574E  0000              add [eax],al
00005750  0000              add [eax],al
00005752  0000              add [eax],al
00005754  0000              add [eax],al
00005756  0000              add [eax],al
00005758  0000              add [eax],al
0000575A  0000              add [eax],al
0000575C  0000              add [eax],al
0000575E  0000              add [eax],al
00005760  0000              add [eax],al
00005762  0000              add [eax],al
00005764  0000              add [eax],al
00005766  0000              add [eax],al
00005768  0000              add [eax],al
0000576A  0000              add [eax],al
0000576C  0000              add [eax],al
0000576E  0000              add [eax],al
00005770  0000              add [eax],al
00005772  0000              add [eax],al
00005774  0000              add [eax],al
00005776  0000              add [eax],al
00005778  0000              add [eax],al
0000577A  0000              add [eax],al
0000577C  0000              add [eax],al
0000577E  0000              add [eax],al
00005780  0000              add [eax],al
00005782  0000              add [eax],al
00005784  0000              add [eax],al
00005786  0000              add [eax],al
00005788  0000              add [eax],al
0000578A  0000              add [eax],al
0000578C  0000              add [eax],al
0000578E  0000              add [eax],al
00005790  0000              add [eax],al
00005792  0000              add [eax],al
00005794  0000              add [eax],al
00005796  0000              add [eax],al
00005798  0000              add [eax],al
0000579A  0000              add [eax],al
0000579C  0000              add [eax],al
0000579E  0000              add [eax],al
000057A0  0000              add [eax],al
000057A2  0000              add [eax],al
000057A4  0000              add [eax],al
000057A6  0000              add [eax],al
000057A8  0000              add [eax],al
000057AA  0000              add [eax],al
000057AC  0000              add [eax],al
000057AE  0000              add [eax],al
000057B0  0000              add [eax],al
000057B2  0000              add [eax],al
000057B4  0000              add [eax],al
000057B6  0000              add [eax],al
000057B8  0000              add [eax],al
000057BA  0000              add [eax],al
000057BC  0000              add [eax],al
000057BE  0000              add [eax],al
000057C0  0000              add [eax],al
000057C2  0000              add [eax],al
000057C4  0000              add [eax],al
000057C6  0000              add [eax],al
000057C8  0000              add [eax],al
000057CA  0000              add [eax],al
000057CC  0000              add [eax],al
000057CE  0000              add [eax],al
000057D0  0000              add [eax],al
000057D2  0000              add [eax],al
000057D4  0000              add [eax],al
000057D6  0000              add [eax],al
000057D8  0000              add [eax],al
000057DA  0000              add [eax],al
000057DC  0000              add [eax],al
000057DE  0000              add [eax],al
000057E0  0000              add [eax],al
000057E2  0000              add [eax],al
000057E4  0000              add [eax],al
000057E6  0000              add [eax],al
000057E8  0000              add [eax],al
000057EA  0000              add [eax],al
000057EC  0000              add [eax],al
000057EE  0000              add [eax],al
000057F0  0000              add [eax],al
000057F2  0000              add [eax],al
000057F4  0000              add [eax],al
000057F6  0000              add [eax],al
000057F8  0000              add [eax],al
000057FA  0000              add [eax],al
000057FC  0000              add [eax],al
000057FE  0000              add [eax],al
00005800  0000              add [eax],al
00005802  0000              add [eax],al
00005804  0000              add [eax],al
00005806  0000              add [eax],al
00005808  0000              add [eax],al
0000580A  0000              add [eax],al
0000580C  0000              add [eax],al
0000580E  0000              add [eax],al
00005810  0000              add [eax],al
00005812  0000              add [eax],al
00005814  0000              add [eax],al
00005816  0000              add [eax],al
00005818  0000              add [eax],al
0000581A  0000              add [eax],al
0000581C  0000              add [eax],al
0000581E  0000              add [eax],al
00005820  0000              add [eax],al
00005822  0000              add [eax],al
00005824  0000              add [eax],al
00005826  0000              add [eax],al
00005828  0000              add [eax],al
0000582A  0000              add [eax],al
0000582C  0000              add [eax],al
0000582E  0000              add [eax],al
00005830  0000              add [eax],al
00005832  0000              add [eax],al
00005834  0000              add [eax],al
00005836  0000              add [eax],al
00005838  0000              add [eax],al
0000583A  0000              add [eax],al
0000583C  0000              add [eax],al
0000583E  0000              add [eax],al
00005840  0000              add [eax],al
00005842  0000              add [eax],al
00005844  0000              add [eax],al
00005846  0000              add [eax],al
00005848  0000              add [eax],al
0000584A  0000              add [eax],al
0000584C  0000              add [eax],al
0000584E  0000              add [eax],al
00005850  0000              add [eax],al
00005852  0000              add [eax],al
00005854  0000              add [eax],al
00005856  0000              add [eax],al
00005858  0000              add [eax],al
0000585A  0000              add [eax],al
0000585C  0000              add [eax],al
0000585E  0000              add [eax],al
00005860  0000              add [eax],al
00005862  0000              add [eax],al
00005864  0000              add [eax],al
00005866  0000              add [eax],al
00005868  0000              add [eax],al
0000586A  0000              add [eax],al
0000586C  0000              add [eax],al
0000586E  0000              add [eax],al
00005870  0000              add [eax],al
00005872  0000              add [eax],al
00005874  0000              add [eax],al
00005876  0000              add [eax],al
00005878  0000              add [eax],al
0000587A  0000              add [eax],al
0000587C  0000              add [eax],al
0000587E  0000              add [eax],al
00005880  0000              add [eax],al
00005882  0000              add [eax],al
00005884  0000              add [eax],al
00005886  0000              add [eax],al
00005888  0000              add [eax],al
0000588A  0000              add [eax],al
0000588C  0000              add [eax],al
0000588E  0000              add [eax],al
00005890  0000              add [eax],al
00005892  0000              add [eax],al
00005894  0000              add [eax],al
00005896  0000              add [eax],al
00005898  0000              add [eax],al
0000589A  0000              add [eax],al
0000589C  0000              add [eax],al
0000589E  0000              add [eax],al
000058A0  0000              add [eax],al
000058A2  0000              add [eax],al
000058A4  0000              add [eax],al
000058A6  0000              add [eax],al
000058A8  0000              add [eax],al
000058AA  0000              add [eax],al
000058AC  0000              add [eax],al
000058AE  0000              add [eax],al
000058B0  0000              add [eax],al
000058B2  0000              add [eax],al
000058B4  0000              add [eax],al
000058B6  0000              add [eax],al
000058B8  0000              add [eax],al
000058BA  0000              add [eax],al
000058BC  0000              add [eax],al
000058BE  0000              add [eax],al
000058C0  0000              add [eax],al
000058C2  0000              add [eax],al
000058C4  0000              add [eax],al
000058C6  0000              add [eax],al
000058C8  0000              add [eax],al
000058CA  0000              add [eax],al
000058CC  0000              add [eax],al
000058CE  0000              add [eax],al
000058D0  0000              add [eax],al
000058D2  0000              add [eax],al
000058D4  0000              add [eax],al
000058D6  0000              add [eax],al
000058D8  0000              add [eax],al
000058DA  0000              add [eax],al
000058DC  0000              add [eax],al
000058DE  0000              add [eax],al
000058E0  0000              add [eax],al
000058E2  0000              add [eax],al
000058E4  0000              add [eax],al
000058E6  0000              add [eax],al
000058E8  0000              add [eax],al
000058EA  0000              add [eax],al
000058EC  0000              add [eax],al
000058EE  0000              add [eax],al
000058F0  0000              add [eax],al
000058F2  0000              add [eax],al
000058F4  0000              add [eax],al
000058F6  0000              add [eax],al
000058F8  0000              add [eax],al
000058FA  0000              add [eax],al
000058FC  0000              add [eax],al
000058FE  0000              add [eax],al
00005900  0000              add [eax],al
00005902  0000              add [eax],al
00005904  0000              add [eax],al
00005906  0000              add [eax],al
00005908  0000              add [eax],al
0000590A  0000              add [eax],al
0000590C  0000              add [eax],al
0000590E  0000              add [eax],al
00005910  0000              add [eax],al
00005912  0000              add [eax],al
00005914  0000              add [eax],al
00005916  0000              add [eax],al
00005918  0000              add [eax],al
0000591A  0000              add [eax],al
0000591C  0000              add [eax],al
0000591E  0000              add [eax],al
00005920  0000              add [eax],al
00005922  0000              add [eax],al
00005924  0000              add [eax],al
00005926  0000              add [eax],al
00005928  0000              add [eax],al
0000592A  0000              add [eax],al
0000592C  0000              add [eax],al
0000592E  0000              add [eax],al
00005930  0000              add [eax],al
00005932  0000              add [eax],al
00005934  0000              add [eax],al
00005936  0000              add [eax],al
00005938  0000              add [eax],al
0000593A  0000              add [eax],al
0000593C  0000              add [eax],al
0000593E  0000              add [eax],al
00005940  0000              add [eax],al
00005942  0000              add [eax],al
00005944  0000              add [eax],al
00005946  0000              add [eax],al
00005948  0000              add [eax],al
0000594A  0000              add [eax],al
0000594C  0000              add [eax],al
0000594E  0000              add [eax],al
00005950  0000              add [eax],al
00005952  0000              add [eax],al
00005954  0000              add [eax],al
00005956  0000              add [eax],al
00005958  0000              add [eax],al
0000595A  0000              add [eax],al
0000595C  0000              add [eax],al
0000595E  0000              add [eax],al
00005960  0000              add [eax],al
00005962  0000              add [eax],al
00005964  0000              add [eax],al
00005966  0000              add [eax],al
00005968  0000              add [eax],al
0000596A  0000              add [eax],al
0000596C  0000              add [eax],al
0000596E  0000              add [eax],al
00005970  0000              add [eax],al
00005972  0000              add [eax],al
00005974  0000              add [eax],al
00005976  0000              add [eax],al
00005978  0000              add [eax],al
0000597A  0000              add [eax],al
0000597C  0000              add [eax],al
0000597E  0000              add [eax],al
00005980  0000              add [eax],al
00005982  0000              add [eax],al
00005984  0000              add [eax],al
00005986  0000              add [eax],al
00005988  0000              add [eax],al
0000598A  0000              add [eax],al
0000598C  0000              add [eax],al
0000598E  0000              add [eax],al
00005990  0000              add [eax],al
00005992  0000              add [eax],al
00005994  0000              add [eax],al
00005996  0000              add [eax],al
00005998  0000              add [eax],al
0000599A  0000              add [eax],al
0000599C  0000              add [eax],al
0000599E  0000              add [eax],al
000059A0  0000              add [eax],al
000059A2  0000              add [eax],al
000059A4  0000              add [eax],al
000059A6  0000              add [eax],al
000059A8  0000              add [eax],al
000059AA  0000              add [eax],al
000059AC  0000              add [eax],al
000059AE  0000              add [eax],al
000059B0  0000              add [eax],al
000059B2  0000              add [eax],al
000059B4  0000              add [eax],al
000059B6  0000              add [eax],al
000059B8  0000              add [eax],al
000059BA  0000              add [eax],al
000059BC  0000              add [eax],al
000059BE  0000              add [eax],al
000059C0  0000              add [eax],al
000059C2  0000              add [eax],al
000059C4  0000              add [eax],al
000059C6  0000              add [eax],al
000059C8  0000              add [eax],al
000059CA  0000              add [eax],al
000059CC  0000              add [eax],al
000059CE  0000              add [eax],al
000059D0  0000              add [eax],al
000059D2  0000              add [eax],al
000059D4  0000              add [eax],al
000059D6  0000              add [eax],al
000059D8  0000              add [eax],al
000059DA  0000              add [eax],al
000059DC  0000              add [eax],al
000059DE  0000              add [eax],al
000059E0  0000              add [eax],al
000059E2  0000              add [eax],al
000059E4  0000              add [eax],al
000059E6  0000              add [eax],al
000059E8  0000              add [eax],al
000059EA  0000              add [eax],al
000059EC  0000              add [eax],al
000059EE  0000              add [eax],al
000059F0  0000              add [eax],al
000059F2  0000              add [eax],al
000059F4  0000              add [eax],al
000059F6  0000              add [eax],al
000059F8  0000              add [eax],al
000059FA  0000              add [eax],al
000059FC  0000              add [eax],al
000059FE  0000              add [eax],al
00005A00  0000              add [eax],al
00005A02  0000              add [eax],al
00005A04  0000              add [eax],al
00005A06  0000              add [eax],al
00005A08  0000              add [eax],al
00005A0A  0000              add [eax],al
00005A0C  0000              add [eax],al
00005A0E  0000              add [eax],al
00005A10  0000              add [eax],al
00005A12  0000              add [eax],al
00005A14  0000              add [eax],al
00005A16  0000              add [eax],al
00005A18  0000              add [eax],al
00005A1A  0000              add [eax],al
00005A1C  0000              add [eax],al
00005A1E  0000              add [eax],al
00005A20  0000              add [eax],al
00005A22  0000              add [eax],al
00005A24  0000              add [eax],al
00005A26  0000              add [eax],al
00005A28  0000              add [eax],al
00005A2A  0000              add [eax],al
00005A2C  0000              add [eax],al
00005A2E  0000              add [eax],al
00005A30  0000              add [eax],al
00005A32  0000              add [eax],al
00005A34  0000              add [eax],al
00005A36  0000              add [eax],al
00005A38  0000              add [eax],al
00005A3A  0000              add [eax],al
00005A3C  0000              add [eax],al
00005A3E  0000              add [eax],al
00005A40  0000              add [eax],al
00005A42  0000              add [eax],al
00005A44  0000              add [eax],al
00005A46  0000              add [eax],al
00005A48  0000              add [eax],al
00005A4A  0000              add [eax],al
00005A4C  0000              add [eax],al
00005A4E  0000              add [eax],al
00005A50  0000              add [eax],al
00005A52  0000              add [eax],al
00005A54  0000              add [eax],al
00005A56  0000              add [eax],al
00005A58  0000              add [eax],al
00005A5A  0000              add [eax],al
00005A5C  0000              add [eax],al
00005A5E  0000              add [eax],al
00005A60  0000              add [eax],al
00005A62  0000              add [eax],al
00005A64  0000              add [eax],al
00005A66  0000              add [eax],al
00005A68  0000              add [eax],al
00005A6A  0000              add [eax],al
00005A6C  0000              add [eax],al
00005A6E  0000              add [eax],al
00005A70  0000              add [eax],al
00005A72  0000              add [eax],al
00005A74  0000              add [eax],al
00005A76  0000              add [eax],al
00005A78  0000              add [eax],al
00005A7A  0000              add [eax],al
00005A7C  0000              add [eax],al
00005A7E  0000              add [eax],al
00005A80  0000              add [eax],al
00005A82  0000              add [eax],al
00005A84  0000              add [eax],al
00005A86  0000              add [eax],al
00005A88  0000              add [eax],al
00005A8A  0000              add [eax],al
00005A8C  0000              add [eax],al
00005A8E  0000              add [eax],al
00005A90  0000              add [eax],al
00005A92  0000              add [eax],al
00005A94  0000              add [eax],al
00005A96  0000              add [eax],al
00005A98  0000              add [eax],al
00005A9A  0000              add [eax],al
00005A9C  0000              add [eax],al
00005A9E  0000              add [eax],al
00005AA0  0000              add [eax],al
00005AA2  0000              add [eax],al
00005AA4  0000              add [eax],al
00005AA6  0000              add [eax],al
00005AA8  0000              add [eax],al
00005AAA  0000              add [eax],al
00005AAC  0000              add [eax],al
00005AAE  0000              add [eax],al
00005AB0  0000              add [eax],al
00005AB2  0000              add [eax],al
00005AB4  0000              add [eax],al
00005AB6  0000              add [eax],al
00005AB8  0000              add [eax],al
00005ABA  0000              add [eax],al
00005ABC  0000              add [eax],al
00005ABE  0000              add [eax],al
00005AC0  0000              add [eax],al
00005AC2  0000              add [eax],al
00005AC4  0000              add [eax],al
00005AC6  0000              add [eax],al
00005AC8  0000              add [eax],al
00005ACA  0000              add [eax],al
00005ACC  0000              add [eax],al
00005ACE  0000              add [eax],al
00005AD0  0000              add [eax],al
00005AD2  0000              add [eax],al
00005AD4  0000              add [eax],al
00005AD6  0000              add [eax],al
00005AD8  0000              add [eax],al
00005ADA  0000              add [eax],al
00005ADC  0000              add [eax],al
00005ADE  0000              add [eax],al
00005AE0  0000              add [eax],al
00005AE2  0000              add [eax],al
00005AE4  0000              add [eax],al
00005AE6  0000              add [eax],al
00005AE8  0000              add [eax],al
00005AEA  0000              add [eax],al
00005AEC  0000              add [eax],al
00005AEE  0000              add [eax],al
00005AF0  0000              add [eax],al
00005AF2  0000              add [eax],al
00005AF4  0000              add [eax],al
00005AF6  0000              add [eax],al
00005AF8  0000              add [eax],al
00005AFA  0000              add [eax],al
00005AFC  0000              add [eax],al
00005AFE  0000              add [eax],al
00005B00  0000              add [eax],al
00005B02  0000              add [eax],al
00005B04  0000              add [eax],al
00005B06  0000              add [eax],al
00005B08  0000              add [eax],al
00005B0A  0000              add [eax],al
00005B0C  0000              add [eax],al
00005B0E  0000              add [eax],al
00005B10  0000              add [eax],al
00005B12  0000              add [eax],al
00005B14  0000              add [eax],al
00005B16  0000              add [eax],al
00005B18  0000              add [eax],al
00005B1A  0000              add [eax],al
00005B1C  0000              add [eax],al
00005B1E  0000              add [eax],al
00005B20  0000              add [eax],al
00005B22  0000              add [eax],al
00005B24  0000              add [eax],al
00005B26  0000              add [eax],al
00005B28  0000              add [eax],al
00005B2A  0000              add [eax],al
00005B2C  0000              add [eax],al
00005B2E  0000              add [eax],al
00005B30  0000              add [eax],al
00005B32  0000              add [eax],al
00005B34  0000              add [eax],al
00005B36  0000              add [eax],al
00005B38  0000              add [eax],al
00005B3A  0000              add [eax],al
00005B3C  0000              add [eax],al
00005B3E  0000              add [eax],al
00005B40  0000              add [eax],al
00005B42  0000              add [eax],al
00005B44  0000              add [eax],al
00005B46  0000              add [eax],al
00005B48  0000              add [eax],al
00005B4A  0000              add [eax],al
00005B4C  0000              add [eax],al
00005B4E  0000              add [eax],al
00005B50  0000              add [eax],al
00005B52  0000              add [eax],al
00005B54  0000              add [eax],al
00005B56  0000              add [eax],al
00005B58  0000              add [eax],al
00005B5A  0000              add [eax],al
00005B5C  0000              add [eax],al
00005B5E  0000              add [eax],al
00005B60  0000              add [eax],al
00005B62  0000              add [eax],al
00005B64  0000              add [eax],al
00005B66  0000              add [eax],al
00005B68  0000              add [eax],al
00005B6A  0000              add [eax],al
00005B6C  0000              add [eax],al
00005B6E  0000              add [eax],al
00005B70  0000              add [eax],al
00005B72  0000              add [eax],al
00005B74  0000              add [eax],al
00005B76  0000              add [eax],al
00005B78  0000              add [eax],al
00005B7A  0000              add [eax],al
00005B7C  0000              add [eax],al
00005B7E  0000              add [eax],al
00005B80  0000              add [eax],al
00005B82  0000              add [eax],al
00005B84  0000              add [eax],al
00005B86  0000              add [eax],al
00005B88  0000              add [eax],al
00005B8A  0000              add [eax],al
00005B8C  0000              add [eax],al
00005B8E  0000              add [eax],al
00005B90  0000              add [eax],al
00005B92  0000              add [eax],al
00005B94  0000              add [eax],al
00005B96  0000              add [eax],al
00005B98  0000              add [eax],al
00005B9A  0000              add [eax],al
00005B9C  0000              add [eax],al
00005B9E  0000              add [eax],al
00005BA0  0000              add [eax],al
00005BA2  0000              add [eax],al
00005BA4  0000              add [eax],al
00005BA6  0000              add [eax],al
00005BA8  0000              add [eax],al
00005BAA  0000              add [eax],al
00005BAC  0000              add [eax],al
00005BAE  0000              add [eax],al
00005BB0  0000              add [eax],al
00005BB2  0000              add [eax],al
00005BB4  0000              add [eax],al
00005BB6  0000              add [eax],al
00005BB8  0000              add [eax],al
00005BBA  0000              add [eax],al
00005BBC  0000              add [eax],al
00005BBE  0000              add [eax],al
00005BC0  0000              add [eax],al
00005BC2  0000              add [eax],al
00005BC4  0000              add [eax],al
00005BC6  0000              add [eax],al
00005BC8  0000              add [eax],al
00005BCA  0000              add [eax],al
00005BCC  0000              add [eax],al
00005BCE  0000              add [eax],al
00005BD0  0000              add [eax],al
00005BD2  0000              add [eax],al
00005BD4  0000              add [eax],al
00005BD6  0000              add [eax],al
00005BD8  0000              add [eax],al
00005BDA  0000              add [eax],al
00005BDC  0000              add [eax],al
00005BDE  0000              add [eax],al
00005BE0  0000              add [eax],al
00005BE2  0000              add [eax],al
00005BE4  0000              add [eax],al
00005BE6  0000              add [eax],al
00005BE8  0000              add [eax],al
00005BEA  0000              add [eax],al
00005BEC  0000              add [eax],al
00005BEE  0000              add [eax],al
00005BF0  0000              add [eax],al
00005BF2  0000              add [eax],al
00005BF4  0000              add [eax],al
00005BF6  0000              add [eax],al
00005BF8  0000              add [eax],al
00005BFA  0000              add [eax],al
00005BFC  0000              add [eax],al
00005BFE  0000              add [eax],al
00005C00  0000              add [eax],al
00005C02  0000              add [eax],al
00005C04  0000              add [eax],al
00005C06  0000              add [eax],al
00005C08  0000              add [eax],al
00005C0A  0000              add [eax],al
00005C0C  0000              add [eax],al
00005C0E  0000              add [eax],al
00005C10  0000              add [eax],al
00005C12  0000              add [eax],al
00005C14  0000              add [eax],al
00005C16  0000              add [eax],al
00005C18  0000              add [eax],al
00005C1A  0000              add [eax],al
00005C1C  0000              add [eax],al
00005C1E  0000              add [eax],al
00005C20  0000              add [eax],al
00005C22  0000              add [eax],al
00005C24  0000              add [eax],al
00005C26  0000              add [eax],al
00005C28  0000              add [eax],al
00005C2A  0000              add [eax],al
00005C2C  0000              add [eax],al
00005C2E  0000              add [eax],al
00005C30  0000              add [eax],al
00005C32  0000              add [eax],al
00005C34  0000              add [eax],al
00005C36  0000              add [eax],al
00005C38  0000              add [eax],al
00005C3A  0000              add [eax],al
00005C3C  0000              add [eax],al
00005C3E  0000              add [eax],al
00005C40  0000              add [eax],al
00005C42  0000              add [eax],al
00005C44  0000              add [eax],al
00005C46  0000              add [eax],al
00005C48  0000              add [eax],al
00005C4A  0000              add [eax],al
00005C4C  0000              add [eax],al
00005C4E  0000              add [eax],al
00005C50  0000              add [eax],al
00005C52  0000              add [eax],al
00005C54  0000              add [eax],al
00005C56  0000              add [eax],al
00005C58  0000              add [eax],al
00005C5A  0000              add [eax],al
00005C5C  0000              add [eax],al
00005C5E  0000              add [eax],al
00005C60  0000              add [eax],al
00005C62  0000              add [eax],al
00005C64  0000              add [eax],al
00005C66  0000              add [eax],al
00005C68  0000              add [eax],al
00005C6A  0000              add [eax],al
00005C6C  0000              add [eax],al
00005C6E  0000              add [eax],al
00005C70  0000              add [eax],al
00005C72  0000              add [eax],al
00005C74  0000              add [eax],al
00005C76  0000              add [eax],al
00005C78  0000              add [eax],al
00005C7A  0000              add [eax],al
00005C7C  0000              add [eax],al
00005C7E  0000              add [eax],al
00005C80  0000              add [eax],al
00005C82  0000              add [eax],al
00005C84  0000              add [eax],al
00005C86  0000              add [eax],al
00005C88  0000              add [eax],al
00005C8A  0000              add [eax],al
00005C8C  0000              add [eax],al
00005C8E  0000              add [eax],al
00005C90  0000              add [eax],al
00005C92  0000              add [eax],al
00005C94  0000              add [eax],al
00005C96  0000              add [eax],al
00005C98  0000              add [eax],al
00005C9A  0000              add [eax],al
00005C9C  0000              add [eax],al
00005C9E  0000              add [eax],al
00005CA0  0000              add [eax],al
00005CA2  0000              add [eax],al
00005CA4  0000              add [eax],al
00005CA6  0000              add [eax],al
00005CA8  0000              add [eax],al
00005CAA  0000              add [eax],al
00005CAC  0000              add [eax],al
00005CAE  0000              add [eax],al
00005CB0  0000              add [eax],al
00005CB2  0000              add [eax],al
00005CB4  0000              add [eax],al
00005CB6  0000              add [eax],al
00005CB8  0000              add [eax],al
00005CBA  0000              add [eax],al
00005CBC  0000              add [eax],al
00005CBE  0000              add [eax],al
00005CC0  0000              add [eax],al
00005CC2  0000              add [eax],al
00005CC4  0000              add [eax],al
00005CC6  0000              add [eax],al
00005CC8  0000              add [eax],al
00005CCA  0000              add [eax],al
00005CCC  0000              add [eax],al
00005CCE  0000              add [eax],al
00005CD0  0000              add [eax],al
00005CD2  0000              add [eax],al
00005CD4  0000              add [eax],al
00005CD6  0000              add [eax],al
00005CD8  0000              add [eax],al
00005CDA  0000              add [eax],al
00005CDC  0000              add [eax],al
00005CDE  0000              add [eax],al
00005CE0  0000              add [eax],al
00005CE2  0000              add [eax],al
00005CE4  0000              add [eax],al
00005CE6  0000              add [eax],al
00005CE8  0000              add [eax],al
00005CEA  0000              add [eax],al
00005CEC  0000              add [eax],al
00005CEE  0000              add [eax],al
00005CF0  0000              add [eax],al
00005CF2  0000              add [eax],al
00005CF4  0000              add [eax],al
00005CF6  0000              add [eax],al
00005CF8  0000              add [eax],al
00005CFA  0000              add [eax],al
00005CFC  0000              add [eax],al
00005CFE  0000              add [eax],al
00005D00  0000              add [eax],al
00005D02  0000              add [eax],al
00005D04  0000              add [eax],al
00005D06  0000              add [eax],al
00005D08  0000              add [eax],al
00005D0A  0000              add [eax],al
00005D0C  0000              add [eax],al
00005D0E  0000              add [eax],al
00005D10  0000              add [eax],al
00005D12  0000              add [eax],al
00005D14  0000              add [eax],al
00005D16  0000              add [eax],al
00005D18  0000              add [eax],al
00005D1A  0000              add [eax],al
00005D1C  0000              add [eax],al
00005D1E  0000              add [eax],al
00005D20  0000              add [eax],al
00005D22  0000              add [eax],al
00005D24  0000              add [eax],al
00005D26  0000              add [eax],al
00005D28  0000              add [eax],al
00005D2A  0000              add [eax],al
00005D2C  0000              add [eax],al
00005D2E  0000              add [eax],al
00005D30  0000              add [eax],al
00005D32  0000              add [eax],al
00005D34  0000              add [eax],al
00005D36  0000              add [eax],al
00005D38  0000              add [eax],al
00005D3A  0000              add [eax],al
00005D3C  0000              add [eax],al
00005D3E  0000              add [eax],al
00005D40  0000              add [eax],al
00005D42  0000              add [eax],al
00005D44  0000              add [eax],al
00005D46  0000              add [eax],al
00005D48  0000              add [eax],al
00005D4A  0000              add [eax],al
00005D4C  0000              add [eax],al
00005D4E  0000              add [eax],al
00005D50  0000              add [eax],al
00005D52  0000              add [eax],al
00005D54  0000              add [eax],al
00005D56  0000              add [eax],al
00005D58  0000              add [eax],al
00005D5A  0000              add [eax],al
00005D5C  0000              add [eax],al
00005D5E  0000              add [eax],al
00005D60  0000              add [eax],al
00005D62  0000              add [eax],al
00005D64  0000              add [eax],al
00005D66  0000              add [eax],al
00005D68  0000              add [eax],al
00005D6A  0000              add [eax],al
00005D6C  0000              add [eax],al
00005D6E  0000              add [eax],al
00005D70  0000              add [eax],al
00005D72  0000              add [eax],al
00005D74  0000              add [eax],al
00005D76  0000              add [eax],al
00005D78  0000              add [eax],al
00005D7A  0000              add [eax],al
00005D7C  0000              add [eax],al
00005D7E  0000              add [eax],al
00005D80  0000              add [eax],al
00005D82  0000              add [eax],al
00005D84  0000              add [eax],al
00005D86  0000              add [eax],al
00005D88  0000              add [eax],al
00005D8A  0000              add [eax],al
00005D8C  0000              add [eax],al
00005D8E  0000              add [eax],al
00005D90  0000              add [eax],al
00005D92  0000              add [eax],al
00005D94  0000              add [eax],al
00005D96  0000              add [eax],al
00005D98  0000              add [eax],al
00005D9A  0000              add [eax],al
00005D9C  0000              add [eax],al
00005D9E  0000              add [eax],al
00005DA0  0000              add [eax],al
00005DA2  0000              add [eax],al
00005DA4  0000              add [eax],al
00005DA6  0000              add [eax],al
00005DA8  0000              add [eax],al
00005DAA  0000              add [eax],al
00005DAC  0000              add [eax],al
00005DAE  0000              add [eax],al
00005DB0  0000              add [eax],al
00005DB2  0000              add [eax],al
00005DB4  0000              add [eax],al
00005DB6  0000              add [eax],al
00005DB8  0000              add [eax],al
00005DBA  0000              add [eax],al
00005DBC  0000              add [eax],al
00005DBE  0000              add [eax],al
00005DC0  0000              add [eax],al
00005DC2  0000              add [eax],al
00005DC4  0000              add [eax],al
00005DC6  0000              add [eax],al
00005DC8  0000              add [eax],al
00005DCA  0000              add [eax],al
00005DCC  0000              add [eax],al
00005DCE  0000              add [eax],al
00005DD0  0000              add [eax],al
00005DD2  0000              add [eax],al
00005DD4  0000              add [eax],al
00005DD6  0000              add [eax],al
00005DD8  0000              add [eax],al
00005DDA  0000              add [eax],al
00005DDC  0000              add [eax],al
00005DDE  0000              add [eax],al
00005DE0  0000              add [eax],al
00005DE2  0000              add [eax],al
00005DE4  0000              add [eax],al
00005DE6  0000              add [eax],al
00005DE8  0000              add [eax],al
00005DEA  0000              add [eax],al
00005DEC  0000              add [eax],al
00005DEE  0000              add [eax],al
00005DF0  0000              add [eax],al
00005DF2  0000              add [eax],al
00005DF4  0000              add [eax],al
00005DF6  0000              add [eax],al
00005DF8  0000              add [eax],al
00005DFA  0000              add [eax],al
00005DFC  0000              add [eax],al
00005DFE  0000              add [eax],al
00005E00  0000              add [eax],al
00005E02  0000              add [eax],al
00005E04  0000              add [eax],al
00005E06  0000              add [eax],al
00005E08  0000              add [eax],al
00005E0A  0000              add [eax],al
00005E0C  0000              add [eax],al
00005E0E  0000              add [eax],al
00005E10  0000              add [eax],al
00005E12  0000              add [eax],al
00005E14  0000              add [eax],al
00005E16  0000              add [eax],al
00005E18  0000              add [eax],al
00005E1A  0000              add [eax],al
00005E1C  0000              add [eax],al
00005E1E  0000              add [eax],al
00005E20  0000              add [eax],al
00005E22  0000              add [eax],al
00005E24  0000              add [eax],al
00005E26  0000              add [eax],al
00005E28  0000              add [eax],al
00005E2A  0000              add [eax],al
00005E2C  0000              add [eax],al
00005E2E  0000              add [eax],al
00005E30  0000              add [eax],al
00005E32  0000              add [eax],al
00005E34  0000              add [eax],al
00005E36  0000              add [eax],al
00005E38  0000              add [eax],al
00005E3A  0000              add [eax],al
00005E3C  0000              add [eax],al
00005E3E  0000              add [eax],al
00005E40  0000              add [eax],al
00005E42  0000              add [eax],al
00005E44  0000              add [eax],al
00005E46  0000              add [eax],al
00005E48  0000              add [eax],al
00005E4A  0000              add [eax],al
00005E4C  0000              add [eax],al
00005E4E  0000              add [eax],al
00005E50  0000              add [eax],al
00005E52  0000              add [eax],al
00005E54  0000              add [eax],al
00005E56  0000              add [eax],al
00005E58  0000              add [eax],al
00005E5A  0000              add [eax],al
00005E5C  0000              add [eax],al
00005E5E  0000              add [eax],al
00005E60  0000              add [eax],al
00005E62  0000              add [eax],al
00005E64  0000              add [eax],al
00005E66  0000              add [eax],al
00005E68  0000              add [eax],al
00005E6A  0000              add [eax],al
00005E6C  0000              add [eax],al
00005E6E  0000              add [eax],al
00005E70  0000              add [eax],al
00005E72  0000              add [eax],al
00005E74  0000              add [eax],al
00005E76  0000              add [eax],al
00005E78  0000              add [eax],al
00005E7A  0000              add [eax],al
00005E7C  0000              add [eax],al
00005E7E  0000              add [eax],al
00005E80  0000              add [eax],al
00005E82  0000              add [eax],al
00005E84  0000              add [eax],al
00005E86  0000              add [eax],al
00005E88  0000              add [eax],al
00005E8A  0000              add [eax],al
00005E8C  0000              add [eax],al
00005E8E  0000              add [eax],al
00005E90  0000              add [eax],al
00005E92  0000              add [eax],al
00005E94  0000              add [eax],al
00005E96  0000              add [eax],al
00005E98  0000              add [eax],al
00005E9A  0000              add [eax],al
00005E9C  0000              add [eax],al
00005E9E  0000              add [eax],al
00005EA0  0000              add [eax],al
00005EA2  0000              add [eax],al
00005EA4  0000              add [eax],al
00005EA6  0000              add [eax],al
00005EA8  0000              add [eax],al
00005EAA  0000              add [eax],al
00005EAC  0000              add [eax],al
00005EAE  0000              add [eax],al
00005EB0  0000              add [eax],al
00005EB2  0000              add [eax],al
00005EB4  0000              add [eax],al
00005EB6  0000              add [eax],al
00005EB8  0000              add [eax],al
00005EBA  0000              add [eax],al
00005EBC  0000              add [eax],al
00005EBE  0000              add [eax],al
00005EC0  0000              add [eax],al
00005EC2  0000              add [eax],al
00005EC4  0000              add [eax],al
00005EC6  0000              add [eax],al
00005EC8  0000              add [eax],al
00005ECA  0000              add [eax],al
00005ECC  0000              add [eax],al
00005ECE  0000              add [eax],al
00005ED0  0000              add [eax],al
00005ED2  0000              add [eax],al
00005ED4  0000              add [eax],al
00005ED6  0000              add [eax],al
00005ED8  0000              add [eax],al
00005EDA  0000              add [eax],al
00005EDC  0000              add [eax],al
00005EDE  0000              add [eax],al
00005EE0  0000              add [eax],al
00005EE2  0000              add [eax],al
00005EE4  0000              add [eax],al
00005EE6  0000              add [eax],al
00005EE8  0000              add [eax],al
00005EEA  0000              add [eax],al
00005EEC  0000              add [eax],al
00005EEE  0000              add [eax],al
00005EF0  0000              add [eax],al
00005EF2  0000              add [eax],al
00005EF4  0000              add [eax],al
00005EF6  0000              add [eax],al
00005EF8  0000              add [eax],al
00005EFA  0000              add [eax],al
00005EFC  0000              add [eax],al
00005EFE  0000              add [eax],al
00005F00  0000              add [eax],al
00005F02  0000              add [eax],al
00005F04  0000              add [eax],al
00005F06  0000              add [eax],al
00005F08  0000              add [eax],al
00005F0A  0000              add [eax],al
00005F0C  0000              add [eax],al
00005F0E  0000              add [eax],al
00005F10  0000              add [eax],al
00005F12  0000              add [eax],al
00005F14  0000              add [eax],al
00005F16  0000              add [eax],al
00005F18  0000              add [eax],al
00005F1A  0000              add [eax],al
00005F1C  0000              add [eax],al
00005F1E  0000              add [eax],al
00005F20  0000              add [eax],al
00005F22  0000              add [eax],al
00005F24  0000              add [eax],al
00005F26  0000              add [eax],al
00005F28  0000              add [eax],al
00005F2A  0000              add [eax],al
00005F2C  0000              add [eax],al
00005F2E  0000              add [eax],al
00005F30  0000              add [eax],al
00005F32  0000              add [eax],al
00005F34  0000              add [eax],al
00005F36  0000              add [eax],al
00005F38  0000              add [eax],al
00005F3A  0000              add [eax],al
00005F3C  0000              add [eax],al
00005F3E  0000              add [eax],al
00005F40  0000              add [eax],al
00005F42  0000              add [eax],al
00005F44  0000              add [eax],al
00005F46  0000              add [eax],al
00005F48  0000              add [eax],al
00005F4A  0000              add [eax],al
00005F4C  0000              add [eax],al
00005F4E  0000              add [eax],al
00005F50  0000              add [eax],al
00005F52  0000              add [eax],al
00005F54  0000              add [eax],al
00005F56  0000              add [eax],al
00005F58  0000              add [eax],al
00005F5A  0000              add [eax],al
00005F5C  0000              add [eax],al
00005F5E  0000              add [eax],al
00005F60  0000              add [eax],al
00005F62  0000              add [eax],al
00005F64  0000              add [eax],al
00005F66  0000              add [eax],al
00005F68  0000              add [eax],al
00005F6A  0000              add [eax],al
00005F6C  0000              add [eax],al
00005F6E  0000              add [eax],al
00005F70  0000              add [eax],al
00005F72  0000              add [eax],al
00005F74  0000              add [eax],al
00005F76  0000              add [eax],al
00005F78  0000              add [eax],al
00005F7A  0000              add [eax],al
00005F7C  0000              add [eax],al
00005F7E  0000              add [eax],al
00005F80  0000              add [eax],al
00005F82  0000              add [eax],al
00005F84  0000              add [eax],al
00005F86  0000              add [eax],al
00005F88  0000              add [eax],al
00005F8A  0000              add [eax],al
00005F8C  0000              add [eax],al
00005F8E  0000              add [eax],al
00005F90  0000              add [eax],al
00005F92  0000              add [eax],al
00005F94  0000              add [eax],al
00005F96  0000              add [eax],al
00005F98  0000              add [eax],al
00005F9A  0000              add [eax],al
00005F9C  0000              add [eax],al
00005F9E  0000              add [eax],al
00005FA0  0000              add [eax],al
00005FA2  0000              add [eax],al
00005FA4  0000              add [eax],al
00005FA6  0000              add [eax],al
00005FA8  0000              add [eax],al
00005FAA  0000              add [eax],al
00005FAC  0000              add [eax],al
00005FAE  0000              add [eax],al
00005FB0  0000              add [eax],al
00005FB2  0000              add [eax],al
00005FB4  0000              add [eax],al
00005FB6  0000              add [eax],al
00005FB8  0000              add [eax],al
00005FBA  0000              add [eax],al
00005FBC  0000              add [eax],al
00005FBE  0000              add [eax],al
00005FC0  0000              add [eax],al
00005FC2  0000              add [eax],al
00005FC4  0000              add [eax],al
00005FC6  0000              add [eax],al
00005FC8  0000              add [eax],al
00005FCA  0000              add [eax],al
00005FCC  0000              add [eax],al
00005FCE  0000              add [eax],al
00005FD0  0000              add [eax],al
00005FD2  0000              add [eax],al
00005FD4  0000              add [eax],al
00005FD6  0000              add [eax],al
00005FD8  0000              add [eax],al
00005FDA  0000              add [eax],al
00005FDC  0000              add [eax],al
00005FDE  0000              add [eax],al
00005FE0  0000              add [eax],al
00005FE2  0000              add [eax],al
00005FE4  0000              add [eax],al
00005FE6  0000              add [eax],al
00005FE8  0000              add [eax],al
00005FEA  0000              add [eax],al
00005FEC  0000              add [eax],al
00005FEE  0000              add [eax],al
00005FF0  0000              add [eax],al
00005FF2  0000              add [eax],al
00005FF4  0000              add [eax],al
00005FF6  0000              add [eax],al
00005FF8  0000              add [eax],al
00005FFA  0000              add [eax],al
00005FFC  0000              add [eax],al
00005FFE  0000              add [eax],al
00006000  0000              add [eax],al
00006002  0000              add [eax],al
00006004  0000              add [eax],al
00006006  0000              add [eax],al
00006008  0000              add [eax],al
0000600A  0000              add [eax],al
0000600C  0000              add [eax],al
0000600E  0000              add [eax],al
00006010  0000              add [eax],al
00006012  0000              add [eax],al
00006014  0000              add [eax],al
00006016  0000              add [eax],al
00006018  0000              add [eax],al
0000601A  0000              add [eax],al
0000601C  0000              add [eax],al
0000601E  0000              add [eax],al
00006020  0000              add [eax],al
00006022  0000              add [eax],al
00006024  0000              add [eax],al
00006026  0000              add [eax],al
00006028  0000              add [eax],al
0000602A  0000              add [eax],al
0000602C  0000              add [eax],al
0000602E  0000              add [eax],al
00006030  0000              add [eax],al
00006032  0000              add [eax],al
00006034  0000              add [eax],al
00006036  0000              add [eax],al
00006038  0000              add [eax],al
0000603A  0000              add [eax],al
0000603C  0000              add [eax],al
0000603E  0000              add [eax],al
00006040  0000              add [eax],al
00006042  0000              add [eax],al
00006044  0000              add [eax],al
00006046  0000              add [eax],al
00006048  0000              add [eax],al
0000604A  0000              add [eax],al
0000604C  0000              add [eax],al
0000604E  0000              add [eax],al
00006050  0000              add [eax],al
00006052  0000              add [eax],al
00006054  0000              add [eax],al
00006056  0000              add [eax],al
00006058  0000              add [eax],al
0000605A  0000              add [eax],al
0000605C  0000              add [eax],al
0000605E  0000              add [eax],al
00006060  0000              add [eax],al
00006062  0000              add [eax],al
00006064  0000              add [eax],al
00006066  0000              add [eax],al
00006068  0000              add [eax],al
0000606A  0000              add [eax],al
0000606C  0000              add [eax],al
0000606E  0000              add [eax],al
00006070  0000              add [eax],al
00006072  0000              add [eax],al
00006074  0000              add [eax],al
00006076  0000              add [eax],al
00006078  0000              add [eax],al
0000607A  0000              add [eax],al
0000607C  0000              add [eax],al
0000607E  0000              add [eax],al
00006080  0000              add [eax],al
00006082  0000              add [eax],al
00006084  0000              add [eax],al
00006086  0000              add [eax],al
00006088  0000              add [eax],al
0000608A  0000              add [eax],al
0000608C  0000              add [eax],al
0000608E  0000              add [eax],al
00006090  0000              add [eax],al
00006092  0000              add [eax],al
00006094  0000              add [eax],al
00006096  0000              add [eax],al
00006098  0000              add [eax],al
0000609A  0000              add [eax],al
0000609C  0000              add [eax],al
0000609E  0000              add [eax],al
000060A0  0000              add [eax],al
000060A2  0000              add [eax],al
000060A4  0000              add [eax],al
000060A6  0000              add [eax],al
000060A8  0000              add [eax],al
000060AA  0000              add [eax],al
000060AC  0000              add [eax],al
000060AE  0000              add [eax],al
000060B0  0000              add [eax],al
000060B2  0000              add [eax],al
000060B4  0000              add [eax],al
000060B6  0000              add [eax],al
000060B8  0000              add [eax],al
000060BA  0000              add [eax],al
000060BC  0000              add [eax],al
000060BE  0000              add [eax],al
000060C0  0000              add [eax],al
000060C2  0000              add [eax],al
000060C4  0000              add [eax],al
000060C6  0000              add [eax],al
000060C8  0000              add [eax],al
000060CA  0000              add [eax],al
000060CC  0000              add [eax],al
000060CE  0000              add [eax],al
000060D0  0000              add [eax],al
000060D2  0000              add [eax],al
000060D4  0000              add [eax],al
000060D6  0000              add [eax],al
000060D8  0000              add [eax],al
000060DA  0000              add [eax],al
000060DC  0000              add [eax],al
000060DE  0000              add [eax],al
000060E0  0000              add [eax],al
000060E2  0000              add [eax],al
000060E4  0000              add [eax],al
000060E6  0000              add [eax],al
000060E8  0000              add [eax],al
000060EA  0000              add [eax],al
000060EC  0000              add [eax],al
000060EE  0000              add [eax],al
000060F0  0000              add [eax],al
000060F2  0000              add [eax],al
000060F4  0000              add [eax],al
000060F6  0000              add [eax],al
000060F8  0000              add [eax],al
000060FA  0000              add [eax],al
000060FC  0000              add [eax],al
000060FE  0000              add [eax],al
00006100  0000              add [eax],al
00006102  0000              add [eax],al
00006104  0000              add [eax],al
00006106  0000              add [eax],al
00006108  0000              add [eax],al
0000610A  0000              add [eax],al
0000610C  0000              add [eax],al
0000610E  0000              add [eax],al
00006110  0000              add [eax],al
00006112  0000              add [eax],al
00006114  0000              add [eax],al
00006116  0000              add [eax],al
00006118  0000              add [eax],al
0000611A  0000              add [eax],al
0000611C  0000              add [eax],al
0000611E  0000              add [eax],al
00006120  0000              add [eax],al
00006122  0000              add [eax],al
00006124  0000              add [eax],al
00006126  0000              add [eax],al
00006128  0000              add [eax],al
0000612A  0000              add [eax],al
0000612C  0000              add [eax],al
0000612E  0000              add [eax],al
00006130  0000              add [eax],al
00006132  0000              add [eax],al
00006134  0000              add [eax],al
00006136  0000              add [eax],al
00006138  0000              add [eax],al
0000613A  0000              add [eax],al
0000613C  0000              add [eax],al
0000613E  0000              add [eax],al
00006140  0000              add [eax],al
00006142  0000              add [eax],al
00006144  0000              add [eax],al
00006146  0000              add [eax],al
00006148  0000              add [eax],al
0000614A  0000              add [eax],al
0000614C  0000              add [eax],al
0000614E  0000              add [eax],al
00006150  0000              add [eax],al
00006152  0000              add [eax],al
00006154  0000              add [eax],al
00006156  0000              add [eax],al
00006158  0000              add [eax],al
0000615A  0000              add [eax],al
0000615C  0000              add [eax],al
0000615E  0000              add [eax],al
00006160  0000              add [eax],al
00006162  0000              add [eax],al
00006164  0000              add [eax],al
00006166  0000              add [eax],al
00006168  0000              add [eax],al
0000616A  0000              add [eax],al
0000616C  0000              add [eax],al
0000616E  0000              add [eax],al
00006170  0000              add [eax],al
00006172  0000              add [eax],al
00006174  0000              add [eax],al
00006176  0000              add [eax],al
00006178  0000              add [eax],al
0000617A  0000              add [eax],al
0000617C  0000              add [eax],al
0000617E  0000              add [eax],al
00006180  0000              add [eax],al
00006182  0000              add [eax],al
00006184  0000              add [eax],al
00006186  0000              add [eax],al
00006188  0000              add [eax],al
0000618A  0000              add [eax],al
0000618C  0000              add [eax],al
0000618E  0000              add [eax],al
00006190  0000              add [eax],al
00006192  0000              add [eax],al
00006194  0000              add [eax],al
00006196  0000              add [eax],al
00006198  0000              add [eax],al
0000619A  0000              add [eax],al
0000619C  0000              add [eax],al
0000619E  0000              add [eax],al
000061A0  0000              add [eax],al
000061A2  0000              add [eax],al
000061A4  0000              add [eax],al
000061A6  0000              add [eax],al
000061A8  0000              add [eax],al
000061AA  0000              add [eax],al
000061AC  0000              add [eax],al
000061AE  0000              add [eax],al
000061B0  0000              add [eax],al
000061B2  0000              add [eax],al
000061B4  0000              add [eax],al
000061B6  0000              add [eax],al
000061B8  0000              add [eax],al
000061BA  0000              add [eax],al
000061BC  0000              add [eax],al
000061BE  0000              add [eax],al
000061C0  0000              add [eax],al
000061C2  0000              add [eax],al
000061C4  0000              add [eax],al
000061C6  0000              add [eax],al
000061C8  0000              add [eax],al
000061CA  0000              add [eax],al
000061CC  0000              add [eax],al
000061CE  0000              add [eax],al
000061D0  0000              add [eax],al
000061D2  0000              add [eax],al
000061D4  0000              add [eax],al
000061D6  0000              add [eax],al
000061D8  0000              add [eax],al
000061DA  0000              add [eax],al
000061DC  0000              add [eax],al
000061DE  0000              add [eax],al
000061E0  0000              add [eax],al
000061E2  0000              add [eax],al
000061E4  0000              add [eax],al
000061E6  0000              add [eax],al
000061E8  0000              add [eax],al
000061EA  0000              add [eax],al
000061EC  0000              add [eax],al
000061EE  0000              add [eax],al
000061F0  0000              add [eax],al
000061F2  0000              add [eax],al
000061F4  0000              add [eax],al
000061F6  0000              add [eax],al
000061F8  0000              add [eax],al
000061FA  0000              add [eax],al
000061FC  0000              add [eax],al
000061FE  0000              add [eax],al
00006200  0000              add [eax],al
00006202  0000              add [eax],al
00006204  0000              add [eax],al
00006206  0000              add [eax],al
00006208  0000              add [eax],al
0000620A  0000              add [eax],al
0000620C  0000              add [eax],al
0000620E  0000              add [eax],al
00006210  0000              add [eax],al
00006212  0000              add [eax],al
00006214  0000              add [eax],al
00006216  0000              add [eax],al
00006218  0000              add [eax],al
0000621A  0000              add [eax],al
0000621C  0000              add [eax],al
0000621E  0000              add [eax],al
00006220  0000              add [eax],al
00006222  0000              add [eax],al
00006224  0000              add [eax],al
00006226  0000              add [eax],al
00006228  0000              add [eax],al
0000622A  0000              add [eax],al
0000622C  0000              add [eax],al
0000622E  0000              add [eax],al
00006230  0000              add [eax],al
00006232  0000              add [eax],al
00006234  0000              add [eax],al
00006236  0000              add [eax],al
00006238  0000              add [eax],al
0000623A  0000              add [eax],al
0000623C  0000              add [eax],al
0000623E  0000              add [eax],al
00006240  0000              add [eax],al
00006242  0000              add [eax],al
00006244  0000              add [eax],al
00006246  0000              add [eax],al
00006248  0000              add [eax],al
0000624A  0000              add [eax],al
0000624C  0000              add [eax],al
0000624E  0000              add [eax],al
00006250  0000              add [eax],al
00006252  0000              add [eax],al
00006254  0000              add [eax],al
00006256  0000              add [eax],al
00006258  0000              add [eax],al
0000625A  0000              add [eax],al
0000625C  0000              add [eax],al
0000625E  0000              add [eax],al
00006260  0000              add [eax],al
00006262  0000              add [eax],al
00006264  0000              add [eax],al
00006266  0000              add [eax],al
00006268  0000              add [eax],al
0000626A  0000              add [eax],al
0000626C  0000              add [eax],al
0000626E  0000              add [eax],al
00006270  0000              add [eax],al
00006272  0000              add [eax],al
00006274  0000              add [eax],al
00006276  0000              add [eax],al
00006278  0000              add [eax],al
0000627A  0000              add [eax],al
0000627C  0000              add [eax],al
0000627E  0000              add [eax],al
00006280  0000              add [eax],al
00006282  0000              add [eax],al
00006284  0000              add [eax],al
00006286  0000              add [eax],al
00006288  0000              add [eax],al
0000628A  0000              add [eax],al
0000628C  0000              add [eax],al
0000628E  0000              add [eax],al
00006290  0000              add [eax],al
00006292  0000              add [eax],al
00006294  0000              add [eax],al
00006296  0000              add [eax],al
00006298  0000              add [eax],al
0000629A  0000              add [eax],al
0000629C  0000              add [eax],al
0000629E  0000              add [eax],al
000062A0  0000              add [eax],al
000062A2  0000              add [eax],al
000062A4  0000              add [eax],al
000062A6  0000              add [eax],al
000062A8  0000              add [eax],al
000062AA  0000              add [eax],al
000062AC  0000              add [eax],al
000062AE  0000              add [eax],al
000062B0  0000              add [eax],al
000062B2  0000              add [eax],al
000062B4  0000              add [eax],al
000062B6  0000              add [eax],al
000062B8  0000              add [eax],al
000062BA  0000              add [eax],al
000062BC  0000              add [eax],al
000062BE  0000              add [eax],al
000062C0  0000              add [eax],al
000062C2  0000              add [eax],al
000062C4  0000              add [eax],al
000062C6  0000              add [eax],al
000062C8  0000              add [eax],al
000062CA  0000              add [eax],al
000062CC  0000              add [eax],al
000062CE  0000              add [eax],al
000062D0  0000              add [eax],al
000062D2  0000              add [eax],al
000062D4  0000              add [eax],al
000062D6  0000              add [eax],al
000062D8  0000              add [eax],al
000062DA  0000              add [eax],al
000062DC  0000              add [eax],al
000062DE  0000              add [eax],al
000062E0  0000              add [eax],al
000062E2  0000              add [eax],al
000062E4  0000              add [eax],al
000062E6  0000              add [eax],al
000062E8  0000              add [eax],al
000062EA  0000              add [eax],al
000062EC  0000              add [eax],al
000062EE  0000              add [eax],al
000062F0  0000              add [eax],al
000062F2  0000              add [eax],al
000062F4  0000              add [eax],al
000062F6  0000              add [eax],al
000062F8  0000              add [eax],al
000062FA  0000              add [eax],al
000062FC  0000              add [eax],al
000062FE  0000              add [eax],al
00006300  0000              add [eax],al
00006302  0000              add [eax],al
00006304  0000              add [eax],al
00006306  0000              add [eax],al
00006308  0000              add [eax],al
0000630A  0000              add [eax],al
0000630C  0000              add [eax],al
0000630E  0000              add [eax],al
00006310  0000              add [eax],al
00006312  0000              add [eax],al
00006314  0000              add [eax],al
00006316  0000              add [eax],al
00006318  0000              add [eax],al
0000631A  0000              add [eax],al
0000631C  0000              add [eax],al
0000631E  0000              add [eax],al
00006320  0000              add [eax],al
00006322  0000              add [eax],al
00006324  0000              add [eax],al
00006326  0000              add [eax],al
00006328  0000              add [eax],al
0000632A  0000              add [eax],al
0000632C  0000              add [eax],al
0000632E  0000              add [eax],al
00006330  0000              add [eax],al
00006332  0000              add [eax],al
00006334  0000              add [eax],al
00006336  0000              add [eax],al
00006338  0000              add [eax],al
0000633A  0000              add [eax],al
0000633C  0000              add [eax],al
0000633E  0000              add [eax],al
00006340  0000              add [eax],al
00006342  0000              add [eax],al
00006344  0000              add [eax],al
00006346  0000              add [eax],al
00006348  0000              add [eax],al
0000634A  0000              add [eax],al
0000634C  0000              add [eax],al
0000634E  0000              add [eax],al
00006350  0000              add [eax],al
00006352  0000              add [eax],al
00006354  0000              add [eax],al
00006356  0000              add [eax],al
00006358  0000              add [eax],al
0000635A  0000              add [eax],al
0000635C  0000              add [eax],al
0000635E  0000              add [eax],al
00006360  0000              add [eax],al
00006362  0000              add [eax],al
00006364  0000              add [eax],al
00006366  0000              add [eax],al
00006368  0000              add [eax],al
0000636A  0000              add [eax],al
0000636C  0000              add [eax],al
0000636E  0000              add [eax],al
00006370  0000              add [eax],al
00006372  0000              add [eax],al
00006374  0000              add [eax],al
00006376  0000              add [eax],al
00006378  0000              add [eax],al
0000637A  0000              add [eax],al
0000637C  0000              add [eax],al
0000637E  0000              add [eax],al
00006380  0000              add [eax],al
00006382  0000              add [eax],al
00006384  0000              add [eax],al
00006386  0000              add [eax],al
00006388  0000              add [eax],al
0000638A  0000              add [eax],al
0000638C  0000              add [eax],al
0000638E  0000              add [eax],al
00006390  0000              add [eax],al
00006392  0000              add [eax],al
00006394  0000              add [eax],al
00006396  0000              add [eax],al
00006398  0000              add [eax],al
0000639A  0000              add [eax],al
0000639C  0000              add [eax],al
0000639E  0000              add [eax],al
000063A0  0000              add [eax],al
000063A2  0000              add [eax],al
000063A4  0000              add [eax],al
000063A6  0000              add [eax],al
000063A8  0000              add [eax],al
000063AA  0000              add [eax],al
000063AC  0000              add [eax],al
000063AE  0000              add [eax],al
000063B0  0000              add [eax],al
000063B2  0000              add [eax],al
000063B4  0000              add [eax],al
000063B6  0000              add [eax],al
000063B8  0000              add [eax],al
000063BA  0000              add [eax],al
000063BC  0000              add [eax],al
000063BE  0000              add [eax],al
000063C0  0000              add [eax],al
000063C2  0000              add [eax],al
000063C4  0000              add [eax],al
000063C6  0000              add [eax],al
000063C8  0000              add [eax],al
000063CA  0000              add [eax],al
000063CC  0000              add [eax],al
000063CE  0000              add [eax],al
000063D0  0000              add [eax],al
000063D2  0000              add [eax],al
000063D4  0000              add [eax],al
000063D6  0000              add [eax],al
000063D8  0000              add [eax],al
000063DA  0000              add [eax],al
000063DC  0000              add [eax],al
000063DE  0000              add [eax],al
000063E0  0000              add [eax],al
000063E2  0000              add [eax],al
000063E4  0000              add [eax],al
000063E6  0000              add [eax],al
000063E8  0000              add [eax],al
000063EA  0000              add [eax],al
000063EC  0000              add [eax],al
000063EE  0000              add [eax],al
000063F0  0000              add [eax],al
000063F2  0000              add [eax],al
000063F4  0000              add [eax],al
000063F6  0000              add [eax],al
000063F8  0000              add [eax],al
000063FA  0000              add [eax],al
000063FC  0000              add [eax],al
000063FE  0000              add [eax],al
00006400  0000              add [eax],al
00006402  0000              add [eax],al
00006404  0000              add [eax],al
00006406  0000              add [eax],al
00006408  0000              add [eax],al
0000640A  0000              add [eax],al
0000640C  0000              add [eax],al
0000640E  0000              add [eax],al
00006410  0000              add [eax],al
00006412  0000              add [eax],al
00006414  0000              add [eax],al
00006416  0000              add [eax],al
00006418  0000              add [eax],al
0000641A  0000              add [eax],al
0000641C  0000              add [eax],al
0000641E  0000              add [eax],al
00006420  0000              add [eax],al
00006422  0000              add [eax],al
00006424  0000              add [eax],al
00006426  0000              add [eax],al
00006428  0000              add [eax],al
0000642A  0000              add [eax],al
0000642C  0000              add [eax],al
0000642E  0000              add [eax],al
00006430  0000              add [eax],al
00006432  0000              add [eax],al
00006434  0000              add [eax],al
00006436  0000              add [eax],al
00006438  0000              add [eax],al
0000643A  0000              add [eax],al
0000643C  0000              add [eax],al
0000643E  0000              add [eax],al
00006440  0000              add [eax],al
00006442  0000              add [eax],al
00006444  0000              add [eax],al
00006446  0000              add [eax],al
00006448  0000              add [eax],al
0000644A  0000              add [eax],al
0000644C  0000              add [eax],al
0000644E  0000              add [eax],al
00006450  0000              add [eax],al
00006452  0000              add [eax],al
00006454  0000              add [eax],al
00006456  0000              add [eax],al
00006458  0000              add [eax],al
0000645A  0000              add [eax],al
0000645C  0000              add [eax],al
0000645E  0000              add [eax],al
00006460  0000              add [eax],al
00006462  0000              add [eax],al
00006464  0000              add [eax],al
00006466  0000              add [eax],al
00006468  0000              add [eax],al
0000646A  0000              add [eax],al
0000646C  0000              add [eax],al
0000646E  0000              add [eax],al
00006470  0000              add [eax],al
00006472  0000              add [eax],al
00006474  0000              add [eax],al
00006476  0000              add [eax],al
00006478  0000              add [eax],al
0000647A  0000              add [eax],al
0000647C  0000              add [eax],al
0000647E  0000              add [eax],al
00006480  0000              add [eax],al
00006482  0000              add [eax],al
00006484  0000              add [eax],al
00006486  0000              add [eax],al
00006488  0000              add [eax],al
0000648A  0000              add [eax],al
0000648C  0000              add [eax],al
0000648E  0000              add [eax],al
00006490  0000              add [eax],al
00006492  0000              add [eax],al
00006494  0000              add [eax],al
00006496  0000              add [eax],al
00006498  0000              add [eax],al
0000649A  0000              add [eax],al
0000649C  0000              add [eax],al
0000649E  0000              add [eax],al
000064A0  0000              add [eax],al
000064A2  0000              add [eax],al
000064A4  0000              add [eax],al
000064A6  0000              add [eax],al
000064A8  0000              add [eax],al
000064AA  0000              add [eax],al
000064AC  0000              add [eax],al
000064AE  0000              add [eax],al
000064B0  0000              add [eax],al
000064B2  0000              add [eax],al
000064B4  0000              add [eax],al
000064B6  0000              add [eax],al
000064B8  0000              add [eax],al
000064BA  0000              add [eax],al
000064BC  0000              add [eax],al
000064BE  0000              add [eax],al
000064C0  0000              add [eax],al
000064C2  0000              add [eax],al
000064C4  0000              add [eax],al
000064C6  0000              add [eax],al
000064C8  0000              add [eax],al
000064CA  0000              add [eax],al
000064CC  0000              add [eax],al
000064CE  0000              add [eax],al
000064D0  0000              add [eax],al
000064D2  0000              add [eax],al
000064D4  0000              add [eax],al
000064D6  0000              add [eax],al
000064D8  0000              add [eax],al
000064DA  0000              add [eax],al
000064DC  0000              add [eax],al
000064DE  0000              add [eax],al
000064E0  0000              add [eax],al
000064E2  0000              add [eax],al
000064E4  0000              add [eax],al
000064E6  0000              add [eax],al
000064E8  0000              add [eax],al
000064EA  0000              add [eax],al
000064EC  0000              add [eax],al
000064EE  0000              add [eax],al
000064F0  0000              add [eax],al
000064F2  0000              add [eax],al
000064F4  0000              add [eax],al
000064F6  0000              add [eax],al
000064F8  0000              add [eax],al
000064FA  0000              add [eax],al
000064FC  0000              add [eax],al
000064FE  0000              add [eax],al
00006500  0000              add [eax],al
00006502  0000              add [eax],al
00006504  0000              add [eax],al
00006506  0000              add [eax],al
00006508  0000              add [eax],al
0000650A  0000              add [eax],al
0000650C  0000              add [eax],al
0000650E  0000              add [eax],al
00006510  0000              add [eax],al
00006512  0000              add [eax],al
00006514  0000              add [eax],al
00006516  0000              add [eax],al
00006518  0000              add [eax],al
0000651A  0000              add [eax],al
0000651C  0000              add [eax],al
0000651E  0000              add [eax],al
00006520  0000              add [eax],al
00006522  0000              add [eax],al
00006524  0000              add [eax],al
00006526  0000              add [eax],al
00006528  0000              add [eax],al
0000652A  0000              add [eax],al
0000652C  0000              add [eax],al
0000652E  0000              add [eax],al
00006530  0000              add [eax],al
00006532  0000              add [eax],al
00006534  0000              add [eax],al
00006536  0000              add [eax],al
00006538  0000              add [eax],al
0000653A  0000              add [eax],al
0000653C  0000              add [eax],al
0000653E  0000              add [eax],al
00006540  0000              add [eax],al
00006542  0000              add [eax],al
00006544  0000              add [eax],al
00006546  0000              add [eax],al
00006548  0000              add [eax],al
0000654A  0000              add [eax],al
0000654C  0000              add [eax],al
0000654E  0000              add [eax],al
00006550  0000              add [eax],al
00006552  0000              add [eax],al
00006554  0000              add [eax],al
00006556  0000              add [eax],al
00006558  0000              add [eax],al
0000655A  0000              add [eax],al
0000655C  0000              add [eax],al
0000655E  0000              add [eax],al
00006560  0000              add [eax],al
00006562  0000              add [eax],al
00006564  0000              add [eax],al
00006566  0000              add [eax],al
00006568  0000              add [eax],al
0000656A  0000              add [eax],al
0000656C  0000              add [eax],al
0000656E  0000              add [eax],al
00006570  0000              add [eax],al
00006572  0000              add [eax],al
00006574  0000              add [eax],al
00006576  0000              add [eax],al
00006578  0000              add [eax],al
0000657A  0000              add [eax],al
0000657C  0000              add [eax],al
0000657E  0000              add [eax],al
00006580  0000              add [eax],al
00006582  0000              add [eax],al
00006584  0000              add [eax],al
00006586  0000              add [eax],al
00006588  0000              add [eax],al
0000658A  0000              add [eax],al
0000658C  0000              add [eax],al
0000658E  0000              add [eax],al
00006590  0000              add [eax],al
00006592  0000              add [eax],al
00006594  0000              add [eax],al
00006596  0000              add [eax],al
00006598  0000              add [eax],al
0000659A  0000              add [eax],al
0000659C  0000              add [eax],al
0000659E  0000              add [eax],al
000065A0  0000              add [eax],al
000065A2  0000              add [eax],al
000065A4  0000              add [eax],al
000065A6  0000              add [eax],al
000065A8  0000              add [eax],al
000065AA  0000              add [eax],al
000065AC  0000              add [eax],al
000065AE  0000              add [eax],al
000065B0  0000              add [eax],al
000065B2  0000              add [eax],al
000065B4  0000              add [eax],al
000065B6  0000              add [eax],al
000065B8  0000              add [eax],al
000065BA  0000              add [eax],al
000065BC  0000              add [eax],al
000065BE  0000              add [eax],al
000065C0  0000              add [eax],al
000065C2  0000              add [eax],al
000065C4  0000              add [eax],al
000065C6  0000              add [eax],al
000065C8  0000              add [eax],al
000065CA  0000              add [eax],al
000065CC  0000              add [eax],al
000065CE  0000              add [eax],al
000065D0  0000              add [eax],al
000065D2  0000              add [eax],al
000065D4  0000              add [eax],al
000065D6  0000              add [eax],al
000065D8  0000              add [eax],al
000065DA  0000              add [eax],al
000065DC  0000              add [eax],al
000065DE  0000              add [eax],al
000065E0  0000              add [eax],al
000065E2  0000              add [eax],al
000065E4  0000              add [eax],al
000065E6  0000              add [eax],al
000065E8  0000              add [eax],al
000065EA  0000              add [eax],al
000065EC  0000              add [eax],al
000065EE  0000              add [eax],al
000065F0  0000              add [eax],al
000065F2  0000              add [eax],al
000065F4  0000              add [eax],al
000065F6  0000              add [eax],al
000065F8  0000              add [eax],al
000065FA  0000              add [eax],al
000065FC  0000              add [eax],al
000065FE  0000              add [eax],al
00006600  0000              add [eax],al
00006602  0000              add [eax],al
00006604  0000              add [eax],al
00006606  0000              add [eax],al
00006608  0000              add [eax],al
0000660A  0000              add [eax],al
0000660C  0000              add [eax],al
0000660E  0000              add [eax],al
00006610  0000              add [eax],al
00006612  0000              add [eax],al
00006614  0000              add [eax],al
00006616  0000              add [eax],al
00006618  0000              add [eax],al
0000661A  0000              add [eax],al
0000661C  0000              add [eax],al
0000661E  0000              add [eax],al
00006620  0000              add [eax],al
00006622  0000              add [eax],al
00006624  0000              add [eax],al
00006626  0000              add [eax],al
00006628  0000              add [eax],al
0000662A  0000              add [eax],al
0000662C  0000              add [eax],al
0000662E  0000              add [eax],al
00006630  0000              add [eax],al
00006632  0000              add [eax],al
00006634  0000              add [eax],al
00006636  0000              add [eax],al
00006638  0000              add [eax],al
0000663A  0000              add [eax],al
0000663C  0000              add [eax],al
0000663E  0000              add [eax],al
00006640  0000              add [eax],al
00006642  0000              add [eax],al
00006644  0000              add [eax],al
00006646  0000              add [eax],al
00006648  0000              add [eax],al
0000664A  0000              add [eax],al
0000664C  0000              add [eax],al
0000664E  0000              add [eax],al
00006650  0000              add [eax],al
00006652  0000              add [eax],al
00006654  0000              add [eax],al
00006656  0000              add [eax],al
00006658  0000              add [eax],al
0000665A  0000              add [eax],al
0000665C  0000              add [eax],al
0000665E  0000              add [eax],al
00006660  0000              add [eax],al
00006662  0000              add [eax],al
00006664  0000              add [eax],al
00006666  0000              add [eax],al
00006668  0000              add [eax],al
0000666A  0000              add [eax],al
0000666C  0000              add [eax],al
0000666E  0000              add [eax],al
00006670  0000              add [eax],al
00006672  0000              add [eax],al
00006674  0000              add [eax],al
00006676  0000              add [eax],al
00006678  0000              add [eax],al
0000667A  0000              add [eax],al
0000667C  0000              add [eax],al
0000667E  0000              add [eax],al
00006680  0000              add [eax],al
00006682  0000              add [eax],al
00006684  0000              add [eax],al
00006686  0000              add [eax],al
00006688  0000              add [eax],al
0000668A  0000              add [eax],al
0000668C  0000              add [eax],al
0000668E  0000              add [eax],al
00006690  0000              add [eax],al
00006692  0000              add [eax],al
00006694  0000              add [eax],al
00006696  0000              add [eax],al
00006698  0000              add [eax],al
0000669A  0000              add [eax],al
0000669C  0000              add [eax],al
0000669E  0000              add [eax],al
000066A0  0000              add [eax],al
000066A2  0000              add [eax],al
000066A4  0000              add [eax],al
000066A6  0000              add [eax],al
000066A8  0000              add [eax],al
000066AA  0000              add [eax],al
000066AC  0000              add [eax],al
000066AE  0000              add [eax],al
000066B0  0000              add [eax],al
000066B2  0000              add [eax],al
000066B4  0000              add [eax],al
000066B6  0000              add [eax],al
000066B8  0000              add [eax],al
000066BA  0000              add [eax],al
000066BC  0000              add [eax],al
000066BE  0000              add [eax],al
000066C0  0000              add [eax],al
000066C2  0000              add [eax],al
000066C4  0000              add [eax],al
000066C6  0000              add [eax],al
000066C8  0000              add [eax],al
000066CA  0000              add [eax],al
000066CC  0000              add [eax],al
000066CE  0000              add [eax],al
000066D0  0000              add [eax],al
000066D2  0000              add [eax],al
000066D4  0000              add [eax],al
000066D6  0000              add [eax],al
000066D8  0000              add [eax],al
000066DA  0000              add [eax],al
000066DC  0000              add [eax],al
000066DE  0000              add [eax],al
000066E0  0000              add [eax],al
000066E2  0000              add [eax],al
000066E4  0000              add [eax],al
000066E6  0000              add [eax],al
000066E8  0000              add [eax],al
000066EA  0000              add [eax],al
000066EC  0000              add [eax],al
000066EE  0000              add [eax],al
000066F0  0000              add [eax],al
000066F2  0000              add [eax],al
000066F4  0000              add [eax],al
000066F6  0000              add [eax],al
000066F8  0000              add [eax],al
000066FA  0000              add [eax],al
000066FC  0000              add [eax],al
000066FE  0000              add [eax],al
00006700  0000              add [eax],al
00006702  0000              add [eax],al
00006704  0000              add [eax],al
00006706  0000              add [eax],al
00006708  0000              add [eax],al
0000670A  0000              add [eax],al
0000670C  0000              add [eax],al
0000670E  0000              add [eax],al
00006710  0000              add [eax],al
00006712  0000              add [eax],al
00006714  0000              add [eax],al
00006716  0000              add [eax],al
00006718  0000              add [eax],al
0000671A  0000              add [eax],al
0000671C  0000              add [eax],al
0000671E  0000              add [eax],al
00006720  0000              add [eax],al
00006722  0000              add [eax],al
00006724  0000              add [eax],al
00006726  0000              add [eax],al
00006728  0000              add [eax],al
0000672A  0000              add [eax],al
0000672C  0000              add [eax],al
0000672E  0000              add [eax],al
00006730  0000              add [eax],al
00006732  0000              add [eax],al
00006734  0000              add [eax],al
00006736  0000              add [eax],al
00006738  0000              add [eax],al
0000673A  0000              add [eax],al
0000673C  0000              add [eax],al
0000673E  0000              add [eax],al
00006740  0000              add [eax],al
00006742  0000              add [eax],al
00006744  0000              add [eax],al
00006746  0000              add [eax],al
00006748  0000              add [eax],al
0000674A  0000              add [eax],al
0000674C  0000              add [eax],al
0000674E  0000              add [eax],al
00006750  0000              add [eax],al
00006752  0000              add [eax],al
00006754  0000              add [eax],al
00006756  0000              add [eax],al
00006758  0000              add [eax],al
0000675A  0000              add [eax],al
0000675C  0000              add [eax],al
0000675E  0000              add [eax],al
00006760  0000              add [eax],al
00006762  0000              add [eax],al
00006764  0000              add [eax],al
00006766  0000              add [eax],al
00006768  0000              add [eax],al
0000676A  0000              add [eax],al
0000676C  0000              add [eax],al
0000676E  0000              add [eax],al
00006770  0000              add [eax],al
00006772  0000              add [eax],al
00006774  0000              add [eax],al
00006776  0000              add [eax],al
00006778  0000              add [eax],al
0000677A  0000              add [eax],al
0000677C  0000              add [eax],al
0000677E  0000              add [eax],al
00006780  0000              add [eax],al
00006782  0000              add [eax],al
00006784  0000              add [eax],al
00006786  0000              add [eax],al
00006788  0000              add [eax],al
0000678A  0000              add [eax],al
0000678C  0000              add [eax],al
0000678E  0000              add [eax],al
00006790  0000              add [eax],al
00006792  0000              add [eax],al
00006794  0000              add [eax],al
00006796  0000              add [eax],al
00006798  0000              add [eax],al
0000679A  0000              add [eax],al
0000679C  0000              add [eax],al
0000679E  0000              add [eax],al
000067A0  0000              add [eax],al
000067A2  0000              add [eax],al
000067A4  0000              add [eax],al
000067A6  0000              add [eax],al
000067A8  0000              add [eax],al
000067AA  0000              add [eax],al
000067AC  0000              add [eax],al
000067AE  0000              add [eax],al
000067B0  0000              add [eax],al
000067B2  0000              add [eax],al
000067B4  0000              add [eax],al
000067B6  0000              add [eax],al
000067B8  0000              add [eax],al
000067BA  0000              add [eax],al
000067BC  0000              add [eax],al
000067BE  0000              add [eax],al
000067C0  0000              add [eax],al
000067C2  0000              add [eax],al
000067C4  0000              add [eax],al
000067C6  0000              add [eax],al
000067C8  0000              add [eax],al
000067CA  0000              add [eax],al
000067CC  0000              add [eax],al
000067CE  0000              add [eax],al
000067D0  0000              add [eax],al
000067D2  0000              add [eax],al
000067D4  0000              add [eax],al
000067D6  0000              add [eax],al
000067D8  0000              add [eax],al
000067DA  0000              add [eax],al
000067DC  0000              add [eax],al
000067DE  0000              add [eax],al
000067E0  0000              add [eax],al
000067E2  0000              add [eax],al
000067E4  0000              add [eax],al
000067E6  0000              add [eax],al
000067E8  0000              add [eax],al
000067EA  0000              add [eax],al
000067EC  0000              add [eax],al
000067EE  0000              add [eax],al
000067F0  0000              add [eax],al
000067F2  0000              add [eax],al
000067F4  0000              add [eax],al
000067F6  0000              add [eax],al
000067F8  0000              add [eax],al
000067FA  0000              add [eax],al
000067FC  0000              add [eax],al
000067FE  0000              add [eax],al
00006800  0000              add [eax],al
00006802  0000              add [eax],al
00006804  0000              add [eax],al
00006806  0000              add [eax],al
00006808  0000              add [eax],al
0000680A  0000              add [eax],al
0000680C  0000              add [eax],al
0000680E  0000              add [eax],al
00006810  0000              add [eax],al
00006812  0000              add [eax],al
00006814  0000              add [eax],al
00006816  0000              add [eax],al
00006818  0000              add [eax],al
0000681A  0000              add [eax],al
0000681C  0000              add [eax],al
0000681E  0000              add [eax],al
00006820  0000              add [eax],al
00006822  0000              add [eax],al
00006824  0000              add [eax],al
00006826  0000              add [eax],al
00006828  0000              add [eax],al
0000682A  0000              add [eax],al
0000682C  0000              add [eax],al
0000682E  0000              add [eax],al
00006830  0000              add [eax],al
00006832  0000              add [eax],al
00006834  0000              add [eax],al
00006836  0000              add [eax],al
00006838  0000              add [eax],al
0000683A  0000              add [eax],al
0000683C  0000              add [eax],al
0000683E  0000              add [eax],al
00006840  0000              add [eax],al
00006842  0000              add [eax],al
00006844  0000              add [eax],al
00006846  0000              add [eax],al
00006848  0000              add [eax],al
0000684A  0000              add [eax],al
0000684C  0000              add [eax],al
0000684E  0000              add [eax],al
00006850  0000              add [eax],al
00006852  0000              add [eax],al
00006854  0000              add [eax],al
00006856  0000              add [eax],al
00006858  0000              add [eax],al
0000685A  0000              add [eax],al
0000685C  0000              add [eax],al
0000685E  0000              add [eax],al
00006860  0000              add [eax],al
00006862  0000              add [eax],al
00006864  0000              add [eax],al
00006866  0000              add [eax],al
00006868  0000              add [eax],al
0000686A  0000              add [eax],al
0000686C  0000              add [eax],al
0000686E  0000              add [eax],al
00006870  0000              add [eax],al
00006872  0000              add [eax],al
00006874  0000              add [eax],al
00006876  0000              add [eax],al
00006878  0000              add [eax],al
0000687A  0000              add [eax],al
0000687C  0000              add [eax],al
0000687E  0000              add [eax],al
00006880  0000              add [eax],al
00006882  0000              add [eax],al
00006884  0000              add [eax],al
00006886  0000              add [eax],al
00006888  0000              add [eax],al
0000688A  0000              add [eax],al
0000688C  0000              add [eax],al
0000688E  0000              add [eax],al
00006890  0000              add [eax],al
00006892  0000              add [eax],al
00006894  0000              add [eax],al
00006896  0000              add [eax],al
00006898  0000              add [eax],al
0000689A  0000              add [eax],al
0000689C  0000              add [eax],al
0000689E  0000              add [eax],al
000068A0  0000              add [eax],al
000068A2  0000              add [eax],al
000068A4  0000              add [eax],al
000068A6  0000              add [eax],al
000068A8  0000              add [eax],al
000068AA  0000              add [eax],al
000068AC  0000              add [eax],al
000068AE  0000              add [eax],al
000068B0  0000              add [eax],al
000068B2  0000              add [eax],al
000068B4  0000              add [eax],al
000068B6  0000              add [eax],al
000068B8  0000              add [eax],al
000068BA  0000              add [eax],al
000068BC  0000              add [eax],al
000068BE  0000              add [eax],al
000068C0  0000              add [eax],al
000068C2  0000              add [eax],al
000068C4  0000              add [eax],al
000068C6  0000              add [eax],al
000068C8  0000              add [eax],al
000068CA  0000              add [eax],al
000068CC  0000              add [eax],al
000068CE  0000              add [eax],al
000068D0  0000              add [eax],al
000068D2  0000              add [eax],al
000068D4  0000              add [eax],al
000068D6  0000              add [eax],al
000068D8  0000              add [eax],al
000068DA  0000              add [eax],al
000068DC  0000              add [eax],al
000068DE  0000              add [eax],al
000068E0  0000              add [eax],al
000068E2  0000              add [eax],al
000068E4  0000              add [eax],al
000068E6  0000              add [eax],al
000068E8  0000              add [eax],al
000068EA  0000              add [eax],al
000068EC  0000              add [eax],al
000068EE  0000              add [eax],al
000068F0  0000              add [eax],al
000068F2  0000              add [eax],al
000068F4  0000              add [eax],al
000068F6  0000              add [eax],al
000068F8  0000              add [eax],al
000068FA  0000              add [eax],al
000068FC  0000              add [eax],al
000068FE  0000              add [eax],al
00006900  0000              add [eax],al
00006902  0000              add [eax],al
00006904  0000              add [eax],al
00006906  0000              add [eax],al
00006908  0000              add [eax],al
0000690A  0000              add [eax],al
0000690C  0000              add [eax],al
0000690E  0000              add [eax],al
00006910  0000              add [eax],al
00006912  0000              add [eax],al
00006914  0000              add [eax],al
00006916  0000              add [eax],al
00006918  0000              add [eax],al
0000691A  0000              add [eax],al
0000691C  0000              add [eax],al
0000691E  0000              add [eax],al
00006920  0000              add [eax],al
00006922  0000              add [eax],al
00006924  0000              add [eax],al
00006926  0000              add [eax],al
00006928  0000              add [eax],al
0000692A  0000              add [eax],al
0000692C  0000              add [eax],al
0000692E  0000              add [eax],al
00006930  0000              add [eax],al
00006932  0000              add [eax],al
00006934  0000              add [eax],al
00006936  0000              add [eax],al
00006938  0000              add [eax],al
0000693A  0000              add [eax],al
0000693C  0000              add [eax],al
0000693E  0000              add [eax],al
00006940  0000              add [eax],al
00006942  0000              add [eax],al
00006944  0000              add [eax],al
00006946  0000              add [eax],al
00006948  0000              add [eax],al
0000694A  0000              add [eax],al
0000694C  0000              add [eax],al
0000694E  0000              add [eax],al
00006950  0000              add [eax],al
00006952  0000              add [eax],al
00006954  0000              add [eax],al
00006956  0000              add [eax],al
00006958  0000              add [eax],al
0000695A  0000              add [eax],al
0000695C  0000              add [eax],al
0000695E  0000              add [eax],al
00006960  0000              add [eax],al
00006962  0000              add [eax],al
00006964  0000              add [eax],al
00006966  0000              add [eax],al
00006968  0000              add [eax],al
0000696A  0000              add [eax],al
0000696C  0000              add [eax],al
0000696E  0000              add [eax],al
00006970  0000              add [eax],al
00006972  0000              add [eax],al
00006974  0000              add [eax],al
00006976  0000              add [eax],al
00006978  0000              add [eax],al
0000697A  0000              add [eax],al
0000697C  0000              add [eax],al
0000697E  0000              add [eax],al
00006980  0000              add [eax],al
00006982  0000              add [eax],al
00006984  0000              add [eax],al
00006986  0000              add [eax],al
00006988  0000              add [eax],al
0000698A  0000              add [eax],al
0000698C  0000              add [eax],al
0000698E  0000              add [eax],al
00006990  0000              add [eax],al
00006992  0000              add [eax],al
00006994  0000              add [eax],al
00006996  0000              add [eax],al
00006998  0000              add [eax],al
0000699A  0000              add [eax],al
0000699C  0000              add [eax],al
0000699E  0000              add [eax],al
000069A0  0000              add [eax],al
000069A2  0000              add [eax],al
000069A4  0000              add [eax],al
000069A6  0000              add [eax],al
000069A8  0000              add [eax],al
000069AA  0000              add [eax],al
000069AC  0000              add [eax],al
000069AE  0000              add [eax],al
000069B0  0000              add [eax],al
000069B2  0000              add [eax],al
000069B4  0000              add [eax],al
000069B6  0000              add [eax],al
000069B8  0000              add [eax],al
000069BA  0000              add [eax],al
000069BC  0000              add [eax],al
000069BE  0000              add [eax],al
000069C0  0000              add [eax],al
000069C2  0000              add [eax],al
000069C4  0000              add [eax],al
000069C6  0000              add [eax],al
000069C8  0000              add [eax],al
000069CA  0000              add [eax],al
000069CC  0000              add [eax],al
000069CE  0000              add [eax],al
000069D0  0000              add [eax],al
000069D2  0000              add [eax],al
000069D4  0000              add [eax],al
000069D6  0000              add [eax],al
000069D8  0000              add [eax],al
000069DA  0000              add [eax],al
000069DC  0000              add [eax],al
000069DE  0000              add [eax],al
000069E0  0000              add [eax],al
000069E2  0000              add [eax],al
000069E4  0000              add [eax],al
000069E6  0000              add [eax],al
000069E8  0000              add [eax],al
000069EA  0000              add [eax],al
000069EC  0000              add [eax],al
000069EE  0000              add [eax],al
000069F0  0000              add [eax],al
000069F2  0000              add [eax],al
000069F4  0000              add [eax],al
000069F6  0000              add [eax],al
000069F8  0000              add [eax],al
000069FA  0000              add [eax],al
000069FC  0000              add [eax],al
000069FE  0000              add [eax],al
00006A00  0000              add [eax],al
00006A02  0000              add [eax],al
00006A04  0000              add [eax],al
00006A06  0000              add [eax],al
00006A08  0000              add [eax],al
00006A0A  0000              add [eax],al
00006A0C  0000              add [eax],al
00006A0E  0000              add [eax],al
00006A10  0000              add [eax],al
00006A12  0000              add [eax],al
00006A14  0000              add [eax],al
00006A16  0000              add [eax],al
00006A18  0000              add [eax],al
00006A1A  0000              add [eax],al
00006A1C  0000              add [eax],al
00006A1E  0000              add [eax],al
00006A20  0000              add [eax],al
00006A22  0000              add [eax],al
00006A24  0000              add [eax],al
00006A26  0000              add [eax],al
00006A28  0000              add [eax],al
00006A2A  0000              add [eax],al
00006A2C  0000              add [eax],al
00006A2E  0000              add [eax],al
00006A30  0000              add [eax],al
00006A32  0000              add [eax],al
00006A34  0000              add [eax],al
00006A36  0000              add [eax],al
00006A38  0000              add [eax],al
00006A3A  0000              add [eax],al
00006A3C  0000              add [eax],al
00006A3E  0000              add [eax],al
00006A40  0000              add [eax],al
00006A42  0000              add [eax],al
00006A44  0000              add [eax],al
00006A46  0000              add [eax],al
00006A48  0000              add [eax],al
00006A4A  0000              add [eax],al
00006A4C  0000              add [eax],al
00006A4E  0000              add [eax],al
00006A50  0000              add [eax],al
00006A52  0000              add [eax],al
00006A54  0000              add [eax],al
00006A56  0000              add [eax],al
00006A58  0000              add [eax],al
00006A5A  0000              add [eax],al
00006A5C  0000              add [eax],al
00006A5E  0000              add [eax],al
00006A60  0000              add [eax],al
00006A62  0000              add [eax],al
00006A64  0000              add [eax],al
00006A66  0000              add [eax],al
00006A68  0000              add [eax],al
00006A6A  0000              add [eax],al
00006A6C  0000              add [eax],al
00006A6E  0000              add [eax],al
00006A70  0000              add [eax],al
00006A72  0000              add [eax],al
00006A74  0000              add [eax],al
00006A76  0000              add [eax],al
00006A78  0000              add [eax],al
00006A7A  0000              add [eax],al
00006A7C  0000              add [eax],al
00006A7E  0000              add [eax],al
00006A80  0000              add [eax],al
00006A82  0000              add [eax],al
00006A84  0000              add [eax],al
00006A86  0000              add [eax],al
00006A88  0000              add [eax],al
00006A8A  0000              add [eax],al
00006A8C  0000              add [eax],al
00006A8E  0000              add [eax],al
00006A90  0000              add [eax],al
00006A92  0000              add [eax],al
00006A94  0000              add [eax],al
00006A96  0000              add [eax],al
00006A98  0000              add [eax],al
00006A9A  0000              add [eax],al
00006A9C  0000              add [eax],al
00006A9E  0000              add [eax],al
00006AA0  0000              add [eax],al
00006AA2  0000              add [eax],al
00006AA4  0000              add [eax],al
00006AA6  0000              add [eax],al
00006AA8  0000              add [eax],al
00006AAA  0000              add [eax],al
00006AAC  0000              add [eax],al
00006AAE  0000              add [eax],al
00006AB0  0000              add [eax],al
00006AB2  0000              add [eax],al
00006AB4  0000              add [eax],al
00006AB6  0000              add [eax],al
00006AB8  0000              add [eax],al
00006ABA  0000              add [eax],al
00006ABC  0000              add [eax],al
00006ABE  0000              add [eax],al
00006AC0  0000              add [eax],al
00006AC2  0000              add [eax],al
00006AC4  0000              add [eax],al
00006AC6  0000              add [eax],al
00006AC8  0000              add [eax],al
00006ACA  0000              add [eax],al
00006ACC  0000              add [eax],al
00006ACE  0000              add [eax],al
00006AD0  0000              add [eax],al
00006AD2  0000              add [eax],al
00006AD4  0000              add [eax],al
00006AD6  0000              add [eax],al
00006AD8  0000              add [eax],al
00006ADA  0000              add [eax],al
00006ADC  0000              add [eax],al
00006ADE  0000              add [eax],al
00006AE0  0000              add [eax],al
00006AE2  0000              add [eax],al
00006AE4  0000              add [eax],al
00006AE6  0000              add [eax],al
00006AE8  0000              add [eax],al
00006AEA  0000              add [eax],al
00006AEC  0000              add [eax],al
00006AEE  0000              add [eax],al
00006AF0  0000              add [eax],al
00006AF2  0000              add [eax],al
00006AF4  0000              add [eax],al
00006AF6  0000              add [eax],al
00006AF8  0000              add [eax],al
00006AFA  0000              add [eax],al
00006AFC  0000              add [eax],al
00006AFE  0000              add [eax],al
00006B00  0000              add [eax],al
00006B02  0000              add [eax],al
00006B04  0000              add [eax],al
00006B06  0000              add [eax],al
00006B08  0000              add [eax],al
00006B0A  0000              add [eax],al
00006B0C  0000              add [eax],al
00006B0E  0000              add [eax],al
00006B10  0000              add [eax],al
00006B12  0000              add [eax],al
00006B14  0000              add [eax],al
00006B16  0000              add [eax],al
00006B18  0000              add [eax],al
00006B1A  0000              add [eax],al
00006B1C  0000              add [eax],al
00006B1E  0000              add [eax],al
00006B20  0000              add [eax],al
00006B22  0000              add [eax],al
00006B24  0000              add [eax],al
00006B26  0000              add [eax],al
00006B28  0000              add [eax],al
00006B2A  0000              add [eax],al
00006B2C  0000              add [eax],al
00006B2E  0000              add [eax],al
00006B30  0000              add [eax],al
00006B32  0000              add [eax],al
00006B34  0000              add [eax],al
00006B36  0000              add [eax],al
00006B38  0000              add [eax],al
00006B3A  0000              add [eax],al
00006B3C  0000              add [eax],al
00006B3E  0000              add [eax],al
00006B40  0000              add [eax],al
00006B42  0000              add [eax],al
00006B44  0000              add [eax],al
00006B46  0000              add [eax],al
00006B48  0000              add [eax],al
00006B4A  0000              add [eax],al
00006B4C  0000              add [eax],al
00006B4E  0000              add [eax],al
00006B50  0000              add [eax],al
00006B52  0000              add [eax],al
00006B54  0000              add [eax],al
00006B56  0000              add [eax],al
00006B58  0000              add [eax],al
00006B5A  0000              add [eax],al
00006B5C  0000              add [eax],al
00006B5E  0000              add [eax],al
00006B60  0000              add [eax],al
00006B62  0000              add [eax],al
00006B64  0000              add [eax],al
00006B66  0000              add [eax],al
00006B68  0000              add [eax],al
00006B6A  0000              add [eax],al
00006B6C  0000              add [eax],al
00006B6E  0000              add [eax],al
00006B70  0000              add [eax],al
00006B72  0000              add [eax],al
00006B74  0000              add [eax],al
00006B76  0000              add [eax],al
00006B78  0000              add [eax],al
00006B7A  0000              add [eax],al
00006B7C  0000              add [eax],al
00006B7E  0000              add [eax],al
00006B80  0000              add [eax],al
00006B82  0000              add [eax],al
00006B84  0000              add [eax],al
00006B86  0000              add [eax],al
00006B88  0000              add [eax],al
00006B8A  0000              add [eax],al
00006B8C  0000              add [eax],al
00006B8E  0000              add [eax],al
00006B90  0000              add [eax],al
00006B92  0000              add [eax],al
00006B94  0000              add [eax],al
00006B96  0000              add [eax],al
00006B98  0000              add [eax],al
00006B9A  0000              add [eax],al
00006B9C  0000              add [eax],al
00006B9E  0000              add [eax],al
00006BA0  0000              add [eax],al
00006BA2  0000              add [eax],al
00006BA4  0000              add [eax],al
00006BA6  0000              add [eax],al
00006BA8  0000              add [eax],al
00006BAA  0000              add [eax],al
00006BAC  0000              add [eax],al
00006BAE  0000              add [eax],al
00006BB0  0000              add [eax],al
00006BB2  0000              add [eax],al
00006BB4  0000              add [eax],al
00006BB6  0000              add [eax],al
00006BB8  0000              add [eax],al
00006BBA  0000              add [eax],al
00006BBC  0000              add [eax],al
00006BBE  0000              add [eax],al
00006BC0  0000              add [eax],al
00006BC2  0000              add [eax],al
00006BC4  0000              add [eax],al
00006BC6  0000              add [eax],al
00006BC8  0000              add [eax],al
00006BCA  0000              add [eax],al
00006BCC  0000              add [eax],al
00006BCE  0000              add [eax],al
00006BD0  0000              add [eax],al
00006BD2  0000              add [eax],al
00006BD4  0000              add [eax],al
00006BD6  0000              add [eax],al
00006BD8  0000              add [eax],al
00006BDA  0000              add [eax],al
00006BDC  0000              add [eax],al
00006BDE  0000              add [eax],al
00006BE0  0000              add [eax],al
00006BE2  0000              add [eax],al
00006BE4  0000              add [eax],al
00006BE6  0000              add [eax],al
00006BE8  0000              add [eax],al
00006BEA  0000              add [eax],al
00006BEC  0000              add [eax],al
00006BEE  0000              add [eax],al
00006BF0  0000              add [eax],al
00006BF2  0000              add [eax],al
00006BF4  0000              add [eax],al
00006BF6  0000              add [eax],al
00006BF8  0000              add [eax],al
00006BFA  0000              add [eax],al
00006BFC  0000              add [eax],al
00006BFE  0000              add [eax],al
00006C00  0000              add [eax],al
00006C02  0000              add [eax],al
00006C04  0000              add [eax],al
00006C06  0000              add [eax],al
00006C08  0000              add [eax],al
00006C0A  0000              add [eax],al
00006C0C  0000              add [eax],al
00006C0E  0000              add [eax],al
00006C10  0000              add [eax],al
00006C12  0000              add [eax],al
00006C14  0000              add [eax],al
00006C16  0000              add [eax],al
00006C18  0000              add [eax],al
00006C1A  0000              add [eax],al
00006C1C  0000              add [eax],al
00006C1E  0000              add [eax],al
00006C20  0000              add [eax],al
00006C22  0000              add [eax],al
00006C24  0000              add [eax],al
00006C26  0000              add [eax],al
00006C28  0000              add [eax],al
00006C2A  0000              add [eax],al
00006C2C  0000              add [eax],al
00006C2E  0000              add [eax],al
00006C30  0000              add [eax],al
00006C32  0000              add [eax],al
00006C34  0000              add [eax],al
00006C36  0000              add [eax],al
00006C38  0000              add [eax],al
00006C3A  0000              add [eax],al
00006C3C  0000              add [eax],al
00006C3E  0000              add [eax],al
00006C40  0000              add [eax],al
00006C42  0000              add [eax],al
00006C44  0000              add [eax],al
00006C46  0000              add [eax],al
00006C48  0000              add [eax],al
00006C4A  0000              add [eax],al
00006C4C  0000              add [eax],al
00006C4E  0000              add [eax],al
00006C50  0000              add [eax],al
00006C52  0000              add [eax],al
00006C54  0000              add [eax],al
00006C56  0000              add [eax],al
00006C58  0000              add [eax],al
00006C5A  0000              add [eax],al
00006C5C  0000              add [eax],al
00006C5E  0000              add [eax],al
00006C60  0000              add [eax],al
00006C62  0000              add [eax],al
00006C64  0000              add [eax],al
00006C66  0000              add [eax],al
00006C68  0000              add [eax],al
00006C6A  0000              add [eax],al
00006C6C  0000              add [eax],al
00006C6E  0000              add [eax],al
00006C70  0000              add [eax],al
00006C72  0000              add [eax],al
00006C74  0000              add [eax],al
00006C76  0000              add [eax],al
00006C78  0000              add [eax],al
00006C7A  0000              add [eax],al
00006C7C  0000              add [eax],al
00006C7E  0000              add [eax],al
00006C80  0000              add [eax],al
00006C82  0000              add [eax],al
00006C84  0000              add [eax],al
00006C86  0000              add [eax],al
00006C88  0000              add [eax],al
00006C8A  0000              add [eax],al
00006C8C  0000              add [eax],al
00006C8E  0000              add [eax],al
00006C90  0000              add [eax],al
00006C92  0000              add [eax],al
00006C94  0000              add [eax],al
00006C96  0000              add [eax],al
00006C98  0000              add [eax],al
00006C9A  0000              add [eax],al
00006C9C  0000              add [eax],al
00006C9E  0000              add [eax],al
00006CA0  0000              add [eax],al
00006CA2  0000              add [eax],al
00006CA4  0000              add [eax],al
00006CA6  0000              add [eax],al
00006CA8  0000              add [eax],al
00006CAA  0000              add [eax],al
00006CAC  0000              add [eax],al
00006CAE  0000              add [eax],al
00006CB0  0000              add [eax],al
00006CB2  0000              add [eax],al
00006CB4  0000              add [eax],al
00006CB6  0000              add [eax],al
00006CB8  0000              add [eax],al
00006CBA  0000              add [eax],al
00006CBC  0000              add [eax],al
00006CBE  0000              add [eax],al
00006CC0  0000              add [eax],al
00006CC2  0000              add [eax],al
00006CC4  0000              add [eax],al
00006CC6  0000              add [eax],al
00006CC8  0000              add [eax],al
00006CCA  0000              add [eax],al
00006CCC  0000              add [eax],al
00006CCE  0000              add [eax],al
00006CD0  0000              add [eax],al
00006CD2  0000              add [eax],al
00006CD4  0000              add [eax],al
00006CD6  0000              add [eax],al
00006CD8  0000              add [eax],al
00006CDA  0000              add [eax],al
00006CDC  0000              add [eax],al
00006CDE  0000              add [eax],al
00006CE0  0000              add [eax],al
00006CE2  0000              add [eax],al
00006CE4  0000              add [eax],al
00006CE6  0000              add [eax],al
00006CE8  0000              add [eax],al
00006CEA  0000              add [eax],al
00006CEC  0000              add [eax],al
00006CEE  0000              add [eax],al
00006CF0  0000              add [eax],al
00006CF2  0000              add [eax],al
00006CF4  0000              add [eax],al
00006CF6  0000              add [eax],al
00006CF8  0000              add [eax],al
00006CFA  0000              add [eax],al
00006CFC  0000              add [eax],al
00006CFE  0000              add [eax],al
00006D00  0000              add [eax],al
00006D02  0000              add [eax],al
00006D04  0000              add [eax],al
00006D06  0000              add [eax],al
00006D08  0000              add [eax],al
00006D0A  0000              add [eax],al
00006D0C  0000              add [eax],al
00006D0E  0000              add [eax],al
00006D10  0000              add [eax],al
00006D12  0000              add [eax],al
00006D14  0000              add [eax],al
00006D16  0000              add [eax],al
00006D18  0000              add [eax],al
00006D1A  0000              add [eax],al
00006D1C  0000              add [eax],al
00006D1E  0000              add [eax],al
00006D20  0000              add [eax],al
00006D22  0000              add [eax],al
00006D24  0000              add [eax],al
00006D26  0000              add [eax],al
00006D28  0000              add [eax],al
00006D2A  0000              add [eax],al
00006D2C  0000              add [eax],al
00006D2E  0000              add [eax],al
00006D30  0000              add [eax],al
00006D32  0000              add [eax],al
00006D34  0000              add [eax],al
00006D36  0000              add [eax],al
00006D38  0000              add [eax],al
00006D3A  0000              add [eax],al
00006D3C  0000              add [eax],al
00006D3E  0000              add [eax],al
00006D40  0000              add [eax],al
00006D42  0000              add [eax],al
00006D44  0000              add [eax],al
00006D46  0000              add [eax],al
00006D48  0000              add [eax],al
00006D4A  0000              add [eax],al
00006D4C  0000              add [eax],al
00006D4E  0000              add [eax],al
00006D50  0000              add [eax],al
00006D52  0000              add [eax],al
00006D54  0000              add [eax],al
00006D56  0000              add [eax],al
00006D58  0000              add [eax],al
00006D5A  0000              add [eax],al
00006D5C  0000              add [eax],al
00006D5E  0000              add [eax],al
00006D60  0000              add [eax],al
00006D62  0000              add [eax],al
00006D64  0000              add [eax],al
00006D66  0000              add [eax],al
00006D68  0000              add [eax],al
00006D6A  0000              add [eax],al
00006D6C  0000              add [eax],al
00006D6E  0000              add [eax],al
00006D70  0000              add [eax],al
00006D72  0000              add [eax],al
00006D74  0000              add [eax],al
00006D76  0000              add [eax],al
00006D78  0000              add [eax],al
00006D7A  0000              add [eax],al
00006D7C  0000              add [eax],al
00006D7E  0000              add [eax],al
00006D80  0000              add [eax],al
00006D82  0000              add [eax],al
00006D84  0000              add [eax],al
00006D86  0000              add [eax],al
00006D88  0000              add [eax],al
00006D8A  0000              add [eax],al
00006D8C  0000              add [eax],al
00006D8E  0000              add [eax],al
00006D90  0000              add [eax],al
00006D92  0000              add [eax],al
00006D94  0000              add [eax],al
00006D96  0000              add [eax],al
00006D98  0000              add [eax],al
00006D9A  0000              add [eax],al
00006D9C  0000              add [eax],al
00006D9E  0000              add [eax],al
00006DA0  0000              add [eax],al
00006DA2  0000              add [eax],al
00006DA4  0000              add [eax],al
00006DA6  0000              add [eax],al
00006DA8  0000              add [eax],al
00006DAA  0000              add [eax],al
00006DAC  0000              add [eax],al
00006DAE  0000              add [eax],al
00006DB0  0000              add [eax],al
00006DB2  0000              add [eax],al
00006DB4  0000              add [eax],al
00006DB6  0000              add [eax],al
00006DB8  0000              add [eax],al
00006DBA  0000              add [eax],al
00006DBC  0000              add [eax],al
00006DBE  0000              add [eax],al
00006DC0  0000              add [eax],al
00006DC2  0000              add [eax],al
00006DC4  0000              add [eax],al
00006DC6  0000              add [eax],al
00006DC8  0000              add [eax],al
00006DCA  0000              add [eax],al
00006DCC  0000              add [eax],al
00006DCE  0000              add [eax],al
00006DD0  0000              add [eax],al
00006DD2  0000              add [eax],al
00006DD4  0000              add [eax],al
00006DD6  0000              add [eax],al
00006DD8  0000              add [eax],al
00006DDA  0000              add [eax],al
00006DDC  0000              add [eax],al
00006DDE  0000              add [eax],al
00006DE0  0000              add [eax],al
00006DE2  0000              add [eax],al
00006DE4  0000              add [eax],al
00006DE6  0000              add [eax],al
00006DE8  0000              add [eax],al
00006DEA  0000              add [eax],al
00006DEC  0000              add [eax],al
00006DEE  0000              add [eax],al
00006DF0  0000              add [eax],al
00006DF2  0000              add [eax],al
00006DF4  0000              add [eax],al
00006DF6  0000              add [eax],al
00006DF8  0000              add [eax],al
00006DFA  0000              add [eax],al
00006DFC  0000              add [eax],al
00006DFE  0000              add [eax],al
00006E00  0000              add [eax],al
00006E02  0000              add [eax],al
00006E04  0000              add [eax],al
00006E06  0000              add [eax],al
00006E08  0000              add [eax],al
00006E0A  0000              add [eax],al
00006E0C  0000              add [eax],al
00006E0E  0000              add [eax],al
00006E10  0000              add [eax],al
00006E12  0000              add [eax],al
00006E14  0000              add [eax],al
00006E16  0000              add [eax],al
00006E18  0000              add [eax],al
00006E1A  0000              add [eax],al
00006E1C  0000              add [eax],al
00006E1E  0000              add [eax],al
00006E20  0000              add [eax],al
00006E22  0000              add [eax],al
00006E24  0000              add [eax],al
00006E26  0000              add [eax],al
00006E28  0000              add [eax],al
00006E2A  0000              add [eax],al
00006E2C  0000              add [eax],al
00006E2E  0000              add [eax],al
00006E30  0000              add [eax],al
00006E32  0000              add [eax],al
00006E34  0000              add [eax],al
00006E36  0000              add [eax],al
00006E38  0000              add [eax],al
00006E3A  0000              add [eax],al
00006E3C  0000              add [eax],al
00006E3E  0000              add [eax],al
00006E40  0000              add [eax],al
00006E42  0000              add [eax],al
00006E44  0000              add [eax],al
00006E46  0000              add [eax],al
00006E48  0000              add [eax],al
00006E4A  0000              add [eax],al
00006E4C  0000              add [eax],al
00006E4E  0000              add [eax],al
00006E50  0000              add [eax],al
00006E52  0000              add [eax],al
00006E54  0000              add [eax],al
00006E56  0000              add [eax],al
00006E58  0000              add [eax],al
00006E5A  0000              add [eax],al
00006E5C  0000              add [eax],al
00006E5E  0000              add [eax],al
00006E60  0000              add [eax],al
00006E62  0000              add [eax],al
00006E64  0000              add [eax],al
00006E66  0000              add [eax],al
00006E68  0000              add [eax],al
00006E6A  0000              add [eax],al
00006E6C  0000              add [eax],al
00006E6E  0000              add [eax],al
00006E70  0000              add [eax],al
00006E72  0000              add [eax],al
00006E74  0000              add [eax],al
00006E76  0000              add [eax],al
00006E78  0000              add [eax],al
00006E7A  0000              add [eax],al
00006E7C  0000              add [eax],al
00006E7E  0000              add [eax],al
00006E80  0000              add [eax],al
00006E82  0000              add [eax],al
00006E84  0000              add [eax],al
00006E86  0000              add [eax],al
00006E88  0000              add [eax],al
00006E8A  0000              add [eax],al
00006E8C  0000              add [eax],al
00006E8E  0000              add [eax],al
00006E90  0000              add [eax],al
00006E92  0000              add [eax],al
00006E94  0000              add [eax],al
00006E96  0000              add [eax],al
00006E98  0000              add [eax],al
00006E9A  0000              add [eax],al
00006E9C  0000              add [eax],al
00006E9E  0000              add [eax],al
00006EA0  0000              add [eax],al
00006EA2  0000              add [eax],al
00006EA4  0000              add [eax],al
00006EA6  0000              add [eax],al
00006EA8  0000              add [eax],al
00006EAA  0000              add [eax],al
00006EAC  0000              add [eax],al
00006EAE  0000              add [eax],al
00006EB0  0000              add [eax],al
00006EB2  0000              add [eax],al
00006EB4  0000              add [eax],al
00006EB6  0000              add [eax],al
00006EB8  0000              add [eax],al
00006EBA  0000              add [eax],al
00006EBC  0000              add [eax],al
00006EBE  0000              add [eax],al
00006EC0  0000              add [eax],al
00006EC2  0000              add [eax],al
00006EC4  0000              add [eax],al
00006EC6  0000              add [eax],al
00006EC8  0000              add [eax],al
00006ECA  0000              add [eax],al
00006ECC  0000              add [eax],al
00006ECE  0000              add [eax],al
00006ED0  0000              add [eax],al
00006ED2  0000              add [eax],al
00006ED4  0000              add [eax],al
00006ED6  0000              add [eax],al
00006ED8  0000              add [eax],al
00006EDA  0000              add [eax],al
00006EDC  0000              add [eax],al
00006EDE  0000              add [eax],al
00006EE0  0000              add [eax],al
00006EE2  0000              add [eax],al
00006EE4  0000              add [eax],al
00006EE6  0000              add [eax],al
00006EE8  0000              add [eax],al
00006EEA  0000              add [eax],al
00006EEC  0000              add [eax],al
00006EEE  0000              add [eax],al
00006EF0  0000              add [eax],al
00006EF2  0000              add [eax],al
00006EF4  0000              add [eax],al
00006EF6  0000              add [eax],al
00006EF8  0000              add [eax],al
00006EFA  0000              add [eax],al
00006EFC  0000              add [eax],al
00006EFE  0000              add [eax],al
00006F00  0000              add [eax],al
00006F02  0000              add [eax],al
00006F04  0000              add [eax],al
00006F06  0000              add [eax],al
00006F08  0000              add [eax],al
00006F0A  0000              add [eax],al
00006F0C  0000              add [eax],al
00006F0E  0000              add [eax],al
00006F10  0000              add [eax],al
00006F12  0000              add [eax],al
00006F14  0000              add [eax],al
00006F16  0000              add [eax],al
00006F18  0000              add [eax],al
00006F1A  0000              add [eax],al
00006F1C  0000              add [eax],al
00006F1E  0000              add [eax],al
00006F20  0000              add [eax],al
00006F22  0000              add [eax],al
00006F24  0000              add [eax],al
00006F26  0000              add [eax],al
00006F28  0000              add [eax],al
00006F2A  0000              add [eax],al
00006F2C  0000              add [eax],al
00006F2E  0000              add [eax],al
00006F30  0000              add [eax],al
00006F32  0000              add [eax],al
00006F34  0000              add [eax],al
00006F36  0000              add [eax],al
00006F38  0000              add [eax],al
00006F3A  0000              add [eax],al
00006F3C  0000              add [eax],al
00006F3E  0000              add [eax],al
00006F40  0000              add [eax],al
00006F42  0000              add [eax],al
00006F44  0000              add [eax],al
00006F46  0000              add [eax],al
00006F48  0000              add [eax],al
00006F4A  0000              add [eax],al
00006F4C  0000              add [eax],al
00006F4E  0000              add [eax],al
00006F50  0000              add [eax],al
00006F52  0000              add [eax],al
00006F54  0000              add [eax],al
00006F56  0000              add [eax],al
00006F58  0000              add [eax],al
00006F5A  0000              add [eax],al
00006F5C  0000              add [eax],al
00006F5E  0000              add [eax],al
00006F60  0000              add [eax],al
00006F62  0000              add [eax],al
00006F64  0000              add [eax],al
00006F66  0000              add [eax],al
00006F68  0000              add [eax],al
00006F6A  0000              add [eax],al
00006F6C  0000              add [eax],al
00006F6E  0000              add [eax],al
00006F70  0000              add [eax],al
00006F72  0000              add [eax],al
00006F74  0000              add [eax],al
00006F76  0000              add [eax],al
00006F78  0000              add [eax],al
00006F7A  0000              add [eax],al
00006F7C  0000              add [eax],al
00006F7E  0000              add [eax],al
00006F80  0000              add [eax],al
00006F82  0000              add [eax],al
00006F84  0000              add [eax],al
00006F86  0000              add [eax],al
00006F88  0000              add [eax],al
00006F8A  0000              add [eax],al
00006F8C  0000              add [eax],al
00006F8E  0000              add [eax],al
00006F90  0000              add [eax],al
00006F92  0000              add [eax],al
00006F94  0000              add [eax],al
00006F96  0000              add [eax],al
00006F98  0000              add [eax],al
00006F9A  0000              add [eax],al
00006F9C  0000              add [eax],al
00006F9E  0000              add [eax],al
00006FA0  0000              add [eax],al
00006FA2  0000              add [eax],al
00006FA4  0000              add [eax],al
00006FA6  0000              add [eax],al
00006FA8  0000              add [eax],al
00006FAA  0000              add [eax],al
00006FAC  0000              add [eax],al
00006FAE  0000              add [eax],al
00006FB0  0000              add [eax],al
00006FB2  0000              add [eax],al
00006FB4  0000              add [eax],al
00006FB6  0000              add [eax],al
00006FB8  0000              add [eax],al
00006FBA  0000              add [eax],al
00006FBC  0000              add [eax],al
00006FBE  0000              add [eax],al
00006FC0  0000              add [eax],al
00006FC2  0000              add [eax],al
00006FC4  0000              add [eax],al
00006FC6  0000              add [eax],al
00006FC8  0000              add [eax],al
00006FCA  0000              add [eax],al
00006FCC  0000              add [eax],al
00006FCE  0000              add [eax],al
00006FD0  0000              add [eax],al
00006FD2  0000              add [eax],al
00006FD4  0000              add [eax],al
00006FD6  0000              add [eax],al
00006FD8  0000              add [eax],al
00006FDA  0000              add [eax],al
00006FDC  0000              add [eax],al
00006FDE  0000              add [eax],al
00006FE0  0000              add [eax],al
00006FE2  0000              add [eax],al
00006FE4  0000              add [eax],al
00006FE6  0000              add [eax],al
00006FE8  0000              add [eax],al
00006FEA  0000              add [eax],al
00006FEC  0000              add [eax],al
00006FEE  0000              add [eax],al
00006FF0  0000              add [eax],al
00006FF2  0000              add [eax],al
00006FF4  0000              add [eax],al
00006FF6  0000              add [eax],al
00006FF8  0000              add [eax],al
00006FFA  0000              add [eax],al
00006FFC  0000              add [eax],al
00006FFE  0000              add [eax],al
00007000  0000              add [eax],al
00007002  0000              add [eax],al
00007004  0000              add [eax],al
00007006  0000              add [eax],al
00007008  0000              add [eax],al
0000700A  0000              add [eax],al
0000700C  0000              add [eax],al
0000700E  0000              add [eax],al
00007010  0000              add [eax],al
00007012  0000              add [eax],al
00007014  0000              add [eax],al
00007016  0000              add [eax],al
00007018  0000              add [eax],al
0000701A  0000              add [eax],al
0000701C  0000              add [eax],al
0000701E  0000              add [eax],al
00007020  0000              add [eax],al
00007022  0000              add [eax],al
00007024  0000              add [eax],al
00007026  0000              add [eax],al
00007028  0000              add [eax],al
0000702A  0000              add [eax],al
0000702C  0000              add [eax],al
0000702E  0000              add [eax],al
00007030  0000              add [eax],al
00007032  0000              add [eax],al
00007034  0000              add [eax],al
00007036  0000              add [eax],al
00007038  0000              add [eax],al
0000703A  0000              add [eax],al
0000703C  0000              add [eax],al
0000703E  0000              add [eax],al
00007040  0000              add [eax],al
00007042  0000              add [eax],al
00007044  0000              add [eax],al
00007046  0000              add [eax],al
00007048  0000              add [eax],al
0000704A  0000              add [eax],al
0000704C  0000              add [eax],al
0000704E  0000              add [eax],al
00007050  0000              add [eax],al
00007052  0000              add [eax],al
00007054  0000              add [eax],al
00007056  0000              add [eax],al
00007058  0000              add [eax],al
0000705A  0000              add [eax],al
0000705C  0000              add [eax],al
0000705E  0000              add [eax],al
00007060  0000              add [eax],al
00007062  0000              add [eax],al
00007064  0000              add [eax],al
00007066  0000              add [eax],al
00007068  0000              add [eax],al
0000706A  0000              add [eax],al
0000706C  0000              add [eax],al
0000706E  0000              add [eax],al
00007070  0000              add [eax],al
00007072  0000              add [eax],al
00007074  0000              add [eax],al
00007076  0000              add [eax],al
00007078  0000              add [eax],al
0000707A  0000              add [eax],al
0000707C  0000              add [eax],al
0000707E  0000              add [eax],al
00007080  0000              add [eax],al
00007082  0000              add [eax],al
00007084  0000              add [eax],al
00007086  0000              add [eax],al
00007088  0000              add [eax],al
0000708A  0000              add [eax],al
0000708C  0000              add [eax],al
0000708E  0000              add [eax],al
00007090  0000              add [eax],al
00007092  0000              add [eax],al
00007094  0000              add [eax],al
00007096  0000              add [eax],al
00007098  0000              add [eax],al
0000709A  0000              add [eax],al
0000709C  0000              add [eax],al
0000709E  0000              add [eax],al
000070A0  0000              add [eax],al
000070A2  0000              add [eax],al
000070A4  0000              add [eax],al
000070A6  0000              add [eax],al
000070A8  0000              add [eax],al
000070AA  0000              add [eax],al
000070AC  0000              add [eax],al
000070AE  0000              add [eax],al
000070B0  0000              add [eax],al
000070B2  0000              add [eax],al
000070B4  0000              add [eax],al
000070B6  0000              add [eax],al
000070B8  0000              add [eax],al
000070BA  0000              add [eax],al
000070BC  0000              add [eax],al
000070BE  0000              add [eax],al
000070C0  0000              add [eax],al
000070C2  0000              add [eax],al
000070C4  0000              add [eax],al
000070C6  0000              add [eax],al
000070C8  0000              add [eax],al
000070CA  0000              add [eax],al
000070CC  0000              add [eax],al
000070CE  0000              add [eax],al
000070D0  0000              add [eax],al
000070D2  0000              add [eax],al
000070D4  0000              add [eax],al
000070D6  0000              add [eax],al
000070D8  0000              add [eax],al
000070DA  0000              add [eax],al
000070DC  0000              add [eax],al
000070DE  0000              add [eax],al
000070E0  0000              add [eax],al
000070E2  0000              add [eax],al
000070E4  0000              add [eax],al
000070E6  0000              add [eax],al
000070E8  0000              add [eax],al
000070EA  0000              add [eax],al
000070EC  0000              add [eax],al
000070EE  0000              add [eax],al
000070F0  0000              add [eax],al
000070F2  0000              add [eax],al
000070F4  0000              add [eax],al
000070F6  0000              add [eax],al
000070F8  0000              add [eax],al
000070FA  0000              add [eax],al
000070FC  0000              add [eax],al
000070FE  0000              add [eax],al
00007100  0000              add [eax],al
00007102  0000              add [eax],al
00007104  0000              add [eax],al
00007106  0000              add [eax],al
00007108  0000              add [eax],al
0000710A  0000              add [eax],al
0000710C  0000              add [eax],al
0000710E  0000              add [eax],al
00007110  0000              add [eax],al
00007112  0000              add [eax],al
00007114  0000              add [eax],al
00007116  0000              add [eax],al
00007118  0000              add [eax],al
0000711A  0000              add [eax],al
0000711C  0000              add [eax],al
0000711E  0000              add [eax],al
00007120  0000              add [eax],al
00007122  0000              add [eax],al
00007124  0000              add [eax],al
00007126  0000              add [eax],al
00007128  FA                cli
00007129  60                pushad
0000712A  9C                pushfd
0000712B  1E                push ds
0000712C  A1C4281000        mov eax,[0x1028c4]
00007131  8920              mov [eax],esp
00007133  60                pushad
00007134  9C                pushfd
00007135  6A00              push byte +0x0
00007137  E88438FFFF        call dword 0xffffa9c0
0000713C  58                pop eax
0000713D  9D                popfd
0000713E  61                popad
0000713F  A1C4281000        mov eax,[0x1028c4]
00007144  83C004            add eax,byte +0x4
00007147  8B00              mov eax,[eax]
00007149  A3C4281000        mov [0x1028c4],eax
0000714E  8B25C4281000      mov esp,[dword 0x1028c4]
00007154  8B2424            mov esp,[esp]
00007157  B020              mov al,0x20
00007159  E620              out 0x20,al
0000715B  1F                pop ds
0000715C  9D                popfd
0000715D  61                popad
0000715E  FB                sti
0000715F  CF                iretd
00007160  2000              and [eax],al
00007162  0000              add [eax],al
00007164  2000              and [eax],al
00007166  0000              add [eax],al
00007168  2000              and [eax],al
0000716A  0000              add [eax],al
0000716C  60                pushad
0000716D  9C                pushfd
0000716E  1E                push ds
0000716F  A164D11000        mov eax,[0x10d164]
00007174  8920              mov [eax],esp
00007176  8B2560D11000      mov esp,[dword 0x10d160]
0000717C  FFE3              jmp ebx
0000717E  892560D11000      mov [dword 0x10d160],esp
00007184  8B44240C          mov eax,[esp+0xc]
00007188  A364D11000        mov [0x10d164],eax
0000718D  8B442404          mov eax,[esp+0x4]
00007191  8B5C2408          mov ebx,[esp+0x8]
00007195  891D68D11000      mov [dword 0x10d168],ebx
0000719B  8B642404          mov esp,[esp+0x4]
0000719F  53                push ebx
000071A0  53                push ebx
000071A1  BBB6D11000        mov ebx,0x10d1b6
000071A6  9A6CD110000800    call dword 0x8:0x10d16c
000071AD  5B                pop ebx
000071AE  891D00311000      mov [dword 0x103100],ebx
000071B4  FFD3              call ebx
000071B6  8B2560D11000      mov esp,[dword 0x10d160]
000071BC  FB                sti
000071BD  C3                ret
000071BE  8B44240C          mov eax,[esp+0xc]
000071C2  A360D11000        mov [0x10d160],eax
000071C7  8B442404          mov eax,[esp+0x4]
000071CB  8B5C2408          mov ebx,[esp+0x8]
000071CF  60                pushad
000071D0  9C                pushfd
000071D1  1E                push ds
000071D2  8B0DC4281000      mov ecx,[dword 0x1028c4]
000071D8  8921              mov [ecx],esp
000071DA  89C4              mov esp,eax
000071DC  A160D11000        mov eax,[0x10d160]
000071E1  A3C4281000        mov [0x1028c4],eax
000071E6  FB                sti
000071E7  FFE3              jmp ebx
000071E9  C3                ret
000071EA  9AF2D110000800    call dword 0x8:0x10d1f2
000071F1  C3                ret
000071F2  FA                cli
000071F3  8B5C2404          mov ebx,[esp+0x4]
000071F7  60                pushad
000071F8  9C                pushfd
000071F9  1E                push ds
000071FA  A1C4281000        mov eax,[0x1028c4]
000071FF  8920              mov [eax],esp
00007201  891DC4281000      mov [dword 0x1028c4],ebx
00007207  89DC              mov esp,ebx
00007209  8B2424            mov esp,[esp]
0000720C  1F                pop ds
0000720D  9D                popfd
0000720E  61                popad
0000720F  FB                sti
00007210  C3                ret
00007211  A1C4281000        mov eax,[0x1028c4]
00007216  8920              mov [eax],esp
00007218  C3                ret
00007219  0000              add [eax],al
0000721B  0000              add [eax],al
0000721D  0000              add [eax],al
0000721F  0000              add [eax],al
00007221  0000              add [eax],al
00007223  0000              add [eax],al
00007225  0000              add [eax],al
00007227  0000              add [eax],al
00007229  0000              add [eax],al
0000722B  0000              add [eax],al
0000722D  0000              add [eax],al
0000722F  0000              add [eax],al
00007231  0000              add [eax],al
00007233  0000              add [eax],al
00007235  0000              add [eax],al
00007237  0000              add [eax],al
00007239  0000              add [eax],al
0000723B  0000              add [eax],al
0000723D  0000              add [eax],al
0000723F  0010              add [eax],dl
00007241  0000              add [eax],al
00007243  0000              add [eax],al
00007245  0000              add [eax],al
00007247  0000              add [eax],al
00007249  0000              add [eax],al
0000724B  0000              add [eax],al
0000724D  0000              add [eax],al
0000724F  0000              add [eax],al
00007251  0000              add [eax],al
00007253  0000              add [eax],al
00007255  0000              add [eax],al
00007257  0000              add [eax],al
00007259  0000              add [eax],al
0000725B  0000              add [eax],al
0000725D  0000              add [eax],al
0000725F  0000              add [eax],al
00007261  0000              add [eax],al
00007263  0000              add [eax],al
00007265  0000              add [eax],al
00007267  0000              add [eax],al
00007269  0000              add [eax],al
0000726B  0000              add [eax],al
0000726D  0000              add [eax],al
0000726F  0000              add [eax],al
00007271  0000              add [eax],al
00007273  0000              add [eax],al
00007275  0000              add [eax],al
00007277  0000              add [eax],al
00007279  0000              add [eax],al
0000727B  0000              add [eax],al
0000727D  0000              add [eax],al
0000727F  0028              add [eax],ch
00007281  D110              rcl dword [eax],1
00007283  0027              add [edi],ah
00007285  90                nop
00007286  1000              adc [eax],al
00007288  389010004990      cmp [eax-0x6fb6fff0],dl
0000728E  1000              adc [eax],al
00007290  5A                pop edx
00007291  90                nop
00007292  1000              adc [eax],al
00007294  6B9010007C9010    imul edx,[eax-0x6f83fff0],byte +0x10
0000729B  008D9010009E      add [ebp-0x61ffef70],cl
000072A1  90                nop
000072A2  1000              adc [eax],al
000072A4  AF                scasd
000072A5  90                nop
000072A6  1000              adc [eax],al
000072A8  C0901000D19010    rcl byte [eax-0x6f2efff0],byte 0x10
000072AF  00E2              add dl,ah
000072B1  90                nop
000072B2  1000              adc [eax],al
000072B4  F390              pause
000072B6  1000              adc [eax],al
000072B8  0491              add al,0x91
000072BA  1000              adc [eax],al
000072BC  1591100000        adc eax,0x1091
000072C1  0000              add [eax],al
000072C3  0000              add [eax],al
000072C5  0000              add [eax],al
000072C7  0000              add [eax],al
000072C9  0000              add [eax],al
000072CB  0000              add [eax],al
000072CD  0000              add [eax],al
000072CF  0000              add [eax],al
000072D1  0000              add [eax],al
000072D3  0000              add [eax],al
000072D5  0000              add [eax],al
000072D7  0000              add [eax],al
000072D9  0000              add [eax],al
000072DB  0000              add [eax],al
000072DD  0000              add [eax],al
000072DF  0000              add [eax],al
000072E1  0000              add [eax],al
000072E3  0000              add [eax],al
000072E5  0000              add [eax],al
000072E7  0000              add [eax],al
000072E9  0000              add [eax],al
000072EB  0000              add [eax],al
000072ED  0000              add [eax],al
000072EF  0000              add [eax],al
000072F1  0000              add [eax],al
000072F3  0000              add [eax],al
000072F5  0000              add [eax],al
000072F7  0000              add [eax],al
000072F9  0000              add [eax],al
000072FB  0000              add [eax],al
000072FD  0000              add [eax],al
000072FF  0000              add [eax],al
00007301  0000              add [eax],al
00007303  0000              add [eax],al
00007305  0000              add [eax],al
00007307  0000              add [eax],al
00007309  0000              add [eax],al
0000730B  0000              add [eax],al
0000730D  0000              add [eax],al
0000730F  0000              add [eax],al
00007311  0000              add [eax],al
00007313  0000              add [eax],al
00007315  0000              add [eax],al
00007317  0000              add [eax],al
00007319  0000              add [eax],al
0000731B  0000              add [eax],al
0000731D  0000              add [eax],al
0000731F  0000              add [eax],al
00007321  0000              add [eax],al
00007323  0000              add [eax],al
00007325  0000              add [eax],al
00007327  0000              add [eax],al
00007329  0000              add [eax],al
0000732B  0000              add [eax],al
0000732D  0000              add [eax],al
0000732F  0000              add [eax],al
00007331  0000              add [eax],al
00007333  0000              add [eax],al
00007335  0000              add [eax],al
00007337  0000              add [eax],al
00007339  0000              add [eax],al
0000733B  0000              add [eax],al
0000733D  0000              add [eax],al
0000733F  0000              add [eax],al
00007341  0000              add [eax],al
00007343  0000              add [eax],al
00007345  0000              add [eax],al
00007347  0000              add [eax],al
00007349  0000              add [eax],al
0000734B  0000              add [eax],al
0000734D  0000              add [eax],al
0000734F  0000              add [eax],al
00007351  0000              add [eax],al
00007353  0000              add [eax],al
00007355  0000              add [eax],al
00007357  0000              add [eax],al
00007359  0000              add [eax],al
0000735B  0000              add [eax],al
0000735D  0000              add [eax],al
0000735F  0000              add [eax],al
00007361  0000              add [eax],al
00007363  0000              add [eax],al
00007365  0000              add [eax],al
00007367  0000              add [eax],al
00007369  0000              add [eax],al
0000736B  0000              add [eax],al
0000736D  0000              add [eax],al
0000736F  0000              add [eax],al
00007371  0000              add [eax],al
00007373  0000              add [eax],al
00007375  0000              add [eax],al
00007377  0000              add [eax],al
00007379  0000              add [eax],al
0000737B  0000              add [eax],al
0000737D  0000              add [eax],al
0000737F  0000              add [eax],al
00007381  0000              add [eax],al
00007383  0000              add [eax],al
00007385  0000              add [eax],al
00007387  0000              add [eax],al
00007389  0000              add [eax],al
0000738B  0000              add [eax],al
0000738D  0000              add [eax],al
0000738F  0000              add [eax],al
00007391  0000              add [eax],al
00007393  0000              add [eax],al
00007395  0000              add [eax],al
00007397  0000              add [eax],al
00007399  0000              add [eax],al
0000739B  0000              add [eax],al
0000739D  0000              add [eax],al
0000739F  0000              add [eax],al
000073A1  0000              add [eax],al
000073A3  0000              add [eax],al
000073A5  0000              add [eax],al
000073A7  0000              add [eax],al
000073A9  0000              add [eax],al
000073AB  0000              add [eax],al
000073AD  0000              add [eax],al
000073AF  0000              add [eax],al
000073B1  0000              add [eax],al
000073B3  0000              add [eax],al
000073B5  0000              add [eax],al
000073B7  0000              add [eax],al
000073B9  0000              add [eax],al
000073BB  0000              add [eax],al
000073BD  0000              add [eax],al
000073BF  0000              add [eax],al
000073C1  0000              add [eax],al
000073C3  0000              add [eax],al
000073C5  0000              add [eax],al
000073C7  0000              add [eax],al
000073C9  0000              add [eax],al
000073CB  0000              add [eax],al
000073CD  0000              add [eax],al
000073CF  0000              add [eax],al
000073D1  0000              add [eax],al
000073D3  0000              add [eax],al
000073D5  0000              add [eax],al
000073D7  0000              add [eax],al
000073D9  0000              add [eax],al
000073DB  0000              add [eax],al
000073DD  0000              add [eax],al
000073DF  0000              add [eax],al
000073E1  0000              add [eax],al
000073E3  0000              add [eax],al
000073E5  0000              add [eax],al
000073E7  0000              add [eax],al
000073E9  0000              add [eax],al
000073EB  0000              add [eax],al
000073ED  0000              add [eax],al
000073EF  0000              add [eax],al
000073F1  0000              add [eax],al
000073F3  0000              add [eax],al
000073F5  0000              add [eax],al
000073F7  0000              add [eax],al
000073F9  0000              add [eax],al
000073FB  0000              add [eax],al
000073FD  0000              add [eax],al
000073FF  0000              add [eax],al
00007401  0000              add [eax],al
00007403  0000              add [eax],al
00007405  0000              add [eax],al
00007407  0000              add [eax],al
00007409  0000              add [eax],al
0000740B  0000              add [eax],al
0000740D  0000              add [eax],al
0000740F  0000              add [eax],al
00007411  0000              add [eax],al
00007413  0000              add [eax],al
00007415  0000              add [eax],al
00007417  0000              add [eax],al
00007419  0000              add [eax],al
0000741B  0000              add [eax],al
0000741D  0000              add [eax],al
0000741F  0000              add [eax],al
00007421  0000              add [eax],al
00007423  0000              add [eax],al
00007425  0000              add [eax],al
00007427  0000              add [eax],al
00007429  0000              add [eax],al
0000742B  0000              add [eax],al
0000742D  0000              add [eax],al
0000742F  0000              add [eax],al
00007431  0000              add [eax],al
00007433  0000              add [eax],al
00007435  0000              add [eax],al
00007437  0000              add [eax],al
00007439  0000              add [eax],al
0000743B  0000              add [eax],al
0000743D  0000              add [eax],al
0000743F  0000              add [eax],al
00007441  0000              add [eax],al
00007443  0000              add [eax],al
00007445  0000              add [eax],al
00007447  0000              add [eax],al
00007449  0000              add [eax],al
0000744B  0000              add [eax],al
0000744D  0000              add [eax],al
0000744F  0000              add [eax],al
00007451  0000              add [eax],al
00007453  0000              add [eax],al
00007455  0000              add [eax],al
00007457  0000              add [eax],al
00007459  0000              add [eax],al
0000745B  0000              add [eax],al
0000745D  0000              add [eax],al
0000745F  0000              add [eax],al
00007461  0000              add [eax],al
00007463  0000              add [eax],al
00007465  0000              add [eax],al
00007467  0000              add [eax],al
00007469  0000              add [eax],al
0000746B  0000              add [eax],al
0000746D  0000              add [eax],al
0000746F  0000              add [eax],al
00007471  0000              add [eax],al
00007473  0000              add [eax],al
00007475  0000              add [eax],al
00007477  0000              add [eax],al
00007479  0000              add [eax],al
0000747B  0000              add [eax],al
0000747D  0000              add [eax],al
0000747F  0000              add [eax],al
00007481  0000              add [eax],al
00007483  0000              add [eax],al
00007485  0000              add [eax],al
00007487  0000              add [eax],al
00007489  0000              add [eax],al
0000748B  0000              add [eax],al
0000748D  0000              add [eax],al
0000748F  0000              add [eax],al
00007491  0000              add [eax],al
00007493  0000              add [eax],al
00007495  0000              add [eax],al
00007497  0000              add [eax],al
00007499  0000              add [eax],al
0000749B  0000              add [eax],al
0000749D  0000              add [eax],al
0000749F  0000              add [eax],al
000074A1  0000              add [eax],al
000074A3  0000              add [eax],al
000074A5  0000              add [eax],al
000074A7  0000              add [eax],al
000074A9  0000              add [eax],al
000074AB  0000              add [eax],al
000074AD  0000              add [eax],al
000074AF  0000              add [eax],al
000074B1  0000              add [eax],al
000074B3  0000              add [eax],al
000074B5  0000              add [eax],al
000074B7  0000              add [eax],al
000074B9  0000              add [eax],al
000074BB  0000              add [eax],al
000074BD  0000              add [eax],al
000074BF  0000              add [eax],al
000074C1  0000              add [eax],al
000074C3  0000              add [eax],al
000074C5  0000              add [eax],al
000074C7  0000              add [eax],al
000074C9  0000              add [eax],al
000074CB  0000              add [eax],al
000074CD  0000              add [eax],al
000074CF  0000              add [eax],al
000074D1  0000              add [eax],al
000074D3  0000              add [eax],al
000074D5  0000              add [eax],al
000074D7  0000              add [eax],al
000074D9  0000              add [eax],al
000074DB  0000              add [eax],al
000074DD  0000              add [eax],al
000074DF  0000              add [eax],al
000074E1  0000              add [eax],al
000074E3  0000              add [eax],al
000074E5  0000              add [eax],al
000074E7  0000              add [eax],al
000074E9  0000              add [eax],al
000074EB  0000              add [eax],al
000074ED  0000              add [eax],al
000074EF  0000              add [eax],al
000074F1  0000              add [eax],al
000074F3  0000              add [eax],al
000074F5  0000              add [eax],al
000074F7  0000              add [eax],al
000074F9  0000              add [eax],al
000074FB  0000              add [eax],al
000074FD  0000              add [eax],al
000074FF  0000              add [eax],al
00007501  0000              add [eax],al
00007503  0000              add [eax],al
00007505  0000              add [eax],al
00007507  0000              add [eax],al
00007509  0000              add [eax],al
0000750B  0000              add [eax],al
0000750D  0000              add [eax],al
0000750F  0000              add [eax],al
00007511  0000              add [eax],al
00007513  0000              add [eax],al
00007515  0000              add [eax],al
00007517  0000              add [eax],al
00007519  0000              add [eax],al
0000751B  0000              add [eax],al
0000751D  0000              add [eax],al
0000751F  0000              add [eax],al
00007521  0000              add [eax],al
00007523  0000              add [eax],al
00007525  0000              add [eax],al
00007527  0000              add [eax],al
00007529  0000              add [eax],al
0000752B  0000              add [eax],al
0000752D  0000              add [eax],al
0000752F  0000              add [eax],al
00007531  0000              add [eax],al
00007533  0000              add [eax],al
00007535  0000              add [eax],al
00007537  0000              add [eax],al
00007539  0000              add [eax],al
0000753B  0000              add [eax],al
0000753D  0000              add [eax],al
0000753F  0000              add [eax],al
00007541  0000              add [eax],al
00007543  0000              add [eax],al
00007545  0000              add [eax],al
00007547  0000              add [eax],al
00007549  0000              add [eax],al
0000754B  0000              add [eax],al
0000754D  0000              add [eax],al
0000754F  0000              add [eax],al
00007551  0000              add [eax],al
00007553  0000              add [eax],al
00007555  0000              add [eax],al
00007557  0000              add [eax],al
00007559  0000              add [eax],al
0000755B  0000              add [eax],al
0000755D  0000              add [eax],al
0000755F  0000              add [eax],al
00007561  0000              add [eax],al
00007563  0000              add [eax],al
00007565  0000              add [eax],al
00007567  0000              add [eax],al
00007569  0000              add [eax],al
0000756B  0000              add [eax],al
0000756D  0000              add [eax],al
0000756F  0000              add [eax],al
00007571  0000              add [eax],al
00007573  0000              add [eax],al
00007575  0000              add [eax],al
00007577  0000              add [eax],al
00007579  0000              add [eax],al
0000757B  0000              add [eax],al
0000757D  0000              add [eax],al
0000757F  0000              add [eax],al
00007581  0000              add [eax],al
00007583  0000              add [eax],al
00007585  0000              add [eax],al
00007587  0000              add [eax],al
00007589  0000              add [eax],al
0000758B  0000              add [eax],al
0000758D  0000              add [eax],al
0000758F  0000              add [eax],al
00007591  0000              add [eax],al
00007593  0000              add [eax],al
00007595  0000              add [eax],al
00007597  0000              add [eax],al
00007599  0000              add [eax],al
0000759B  0000              add [eax],al
0000759D  0000              add [eax],al
0000759F  0000              add [eax],al
000075A1  0000              add [eax],al
000075A3  0000              add [eax],al
000075A5  0000              add [eax],al
000075A7  0000              add [eax],al
000075A9  0000              add [eax],al
000075AB  0000              add [eax],al
000075AD  0000              add [eax],al
000075AF  0000              add [eax],al
000075B1  0000              add [eax],al
000075B3  0000              add [eax],al
000075B5  0000              add [eax],al
000075B7  0000              add [eax],al
000075B9  0000              add [eax],al
000075BB  0000              add [eax],al
000075BD  0000              add [eax],al
000075BF  0000              add [eax],al
000075C1  0000              add [eax],al
000075C3  0000              add [eax],al
000075C5  0000              add [eax],al
000075C7  0000              add [eax],al
000075C9  0000              add [eax],al
000075CB  0000              add [eax],al
000075CD  0000              add [eax],al
000075CF  0000              add [eax],al
000075D1  0000              add [eax],al
000075D3  0000              add [eax],al
000075D5  0000              add [eax],al
000075D7  0000              add [eax],al
000075D9  0000              add [eax],al
000075DB  0000              add [eax],al
000075DD  0000              add [eax],al
000075DF  0000              add [eax],al
000075E1  0000              add [eax],al
000075E3  0000              add [eax],al
000075E5  0000              add [eax],al
000075E7  0000              add [eax],al
000075E9  0000              add [eax],al
000075EB  0000              add [eax],al
000075ED  0000              add [eax],al
000075EF  0000              add [eax],al
000075F1  0000              add [eax],al
000075F3  0000              add [eax],al
000075F5  0000              add [eax],al
000075F7  0000              add [eax],al
000075F9  0000              add [eax],al
000075FB  0000              add [eax],al
000075FD  0000              add [eax],al
000075FF  0000              add [eax],al
00007601  0000              add [eax],al
00007603  0000              add [eax],al
00007605  0000              add [eax],al
00007607  0000              add [eax],al
00007609  0000              add [eax],al
0000760B  0000              add [eax],al
0000760D  0000              add [eax],al
0000760F  0000              add [eax],al
00007611  0000              add [eax],al
00007613  0000              add [eax],al
00007615  0000              add [eax],al
00007617  0000              add [eax],al
00007619  0000              add [eax],al
0000761B  0000              add [eax],al
0000761D  0000              add [eax],al
0000761F  0000              add [eax],al
00007621  0000              add [eax],al
00007623  0000              add [eax],al
00007625  0000              add [eax],al
00007627  0000              add [eax],al
00007629  0000              add [eax],al
0000762B  0000              add [eax],al
0000762D  0000              add [eax],al
0000762F  0000              add [eax],al
00007631  0000              add [eax],al
00007633  0000              add [eax],al
00007635  0000              add [eax],al
00007637  0000              add [eax],al
00007639  0000              add [eax],al
0000763B  0000              add [eax],al
0000763D  0000              add [eax],al
0000763F  0000              add [eax],al
00007641  0000              add [eax],al
00007643  0000              add [eax],al
00007645  0000              add [eax],al
00007647  0000              add [eax],al
00007649  0000              add [eax],al
0000764B  0000              add [eax],al
0000764D  0000              add [eax],al
0000764F  0000              add [eax],al
00007651  0000              add [eax],al
00007653  0000              add [eax],al
00007655  0000              add [eax],al
00007657  0000              add [eax],al
00007659  0000              add [eax],al
0000765B  0000              add [eax],al
0000765D  0000              add [eax],al
0000765F  0000              add [eax],al
00007661  0000              add [eax],al
00007663  0000              add [eax],al
00007665  0000              add [eax],al
00007667  0000              add [eax],al
00007669  0000              add [eax],al
0000766B  0000              add [eax],al
0000766D  0000              add [eax],al
0000766F  0000              add [eax],al
00007671  0000              add [eax],al
00007673  0000              add [eax],al
00007675  0000              add [eax],al
00007677  0000              add [eax],al
00007679  0000              add [eax],al
0000767B  0000              add [eax],al
0000767D  0000              add [eax],al
0000767F  0000              add [eax],al
00007681  0000              add [eax],al
00007683  0000              add [eax],al
00007685  0000              add [eax],al
00007687  0000              add [eax],al
00007689  0000              add [eax],al
0000768B  0000              add [eax],al
0000768D  0000              add [eax],al
0000768F  0000              add [eax],al
00007691  0000              add [eax],al
00007693  0000              add [eax],al
00007695  0000              add [eax],al
00007697  0000              add [eax],al
00007699  0000              add [eax],al
0000769B  0000              add [eax],al
0000769D  0000              add [eax],al
0000769F  0000              add [eax],al
000076A1  0000              add [eax],al
000076A3  0000              add [eax],al
000076A5  0000              add [eax],al
000076A7  0000              add [eax],al
000076A9  0000              add [eax],al
000076AB  0000              add [eax],al
000076AD  0000              add [eax],al
000076AF  0000              add [eax],al
000076B1  0000              add [eax],al
000076B3  0000              add [eax],al
000076B5  0000              add [eax],al
000076B7  0000              add [eax],al
000076B9  0000              add [eax],al
000076BB  0000              add [eax],al
000076BD  0000              add [eax],al
000076BF  0000              add [eax],al
000076C1  0000              add [eax],al
000076C3  0000              add [eax],al
000076C5  0000              add [eax],al
000076C7  0000              add [eax],al
000076C9  0000              add [eax],al
000076CB  0000              add [eax],al
000076CD  0000              add [eax],al
000076CF  0000              add [eax],al
000076D1  0000              add [eax],al
000076D3  0000              add [eax],al
000076D5  0000              add [eax],al
000076D7  0000              add [eax],al
000076D9  0000              add [eax],al
000076DB  0000              add [eax],al
000076DD  0000              add [eax],al
000076DF  0000              add [eax],al
000076E1  0000              add [eax],al
000076E3  0000              add [eax],al
000076E5  0000              add [eax],al
000076E7  0000              add [eax],al
000076E9  0000              add [eax],al
000076EB  0000              add [eax],al
000076ED  0000              add [eax],al
000076EF  0000              add [eax],al
000076F1  0000              add [eax],al
000076F3  0000              add [eax],al
000076F5  0000              add [eax],al
000076F7  0000              add [eax],al
000076F9  0000              add [eax],al
000076FB  0000              add [eax],al
000076FD  0000              add [eax],al
000076FF  0000              add [eax],al
00007701  0000              add [eax],al
00007703  0000              add [eax],al
00007705  0000              add [eax],al
00007707  0000              add [eax],al
00007709  0000              add [eax],al
0000770B  0000              add [eax],al
0000770D  0000              add [eax],al
0000770F  0000              add [eax],al
00007711  0000              add [eax],al
00007713  0000              add [eax],al
00007715  0000              add [eax],al
00007717  0000              add [eax],al
00007719  0000              add [eax],al
0000771B  0000              add [eax],al
0000771D  0000              add [eax],al
0000771F  0000              add [eax],al
00007721  0000              add [eax],al
00007723  0000              add [eax],al
00007725  0000              add [eax],al
00007727  0000              add [eax],al
00007729  0000              add [eax],al
0000772B  0000              add [eax],al
0000772D  0000              add [eax],al
0000772F  0000              add [eax],al
00007731  0000              add [eax],al
00007733  0000              add [eax],al
00007735  0000              add [eax],al
00007737  0000              add [eax],al
00007739  0000              add [eax],al
0000773B  0000              add [eax],al
0000773D  0000              add [eax],al
0000773F  0000              add [eax],al
00007741  0000              add [eax],al
00007743  0000              add [eax],al
00007745  0000              add [eax],al
00007747  0000              add [eax],al
00007749  0000              add [eax],al
0000774B  0000              add [eax],al
0000774D  0000              add [eax],al
0000774F  0000              add [eax],al
00007751  0000              add [eax],al
00007753  0000              add [eax],al
00007755  0000              add [eax],al
00007757  0000              add [eax],al
00007759  0000              add [eax],al
0000775B  0000              add [eax],al
0000775D  0000              add [eax],al
0000775F  0000              add [eax],al
00007761  0000              add [eax],al
00007763  0000              add [eax],al
00007765  0000              add [eax],al
00007767  0000              add [eax],al
00007769  0000              add [eax],al
0000776B  0000              add [eax],al
0000776D  0000              add [eax],al
0000776F  0000              add [eax],al
00007771  0000              add [eax],al
00007773  0000              add [eax],al
00007775  0000              add [eax],al
00007777  0000              add [eax],al
00007779  0000              add [eax],al
0000777B  0000              add [eax],al
0000777D  0000              add [eax],al
0000777F  0000              add [eax],al
00007781  0000              add [eax],al
00007783  0000              add [eax],al
00007785  0000              add [eax],al
00007787  0000              add [eax],al
00007789  0000              add [eax],al
0000778B  0000              add [eax],al
0000778D  0000              add [eax],al
0000778F  0000              add [eax],al
00007791  0000              add [eax],al
00007793  0000              add [eax],al
00007795  0000              add [eax],al
00007797  0000              add [eax],al
00007799  0000              add [eax],al
0000779B  0000              add [eax],al
0000779D  0000              add [eax],al
0000779F  0000              add [eax],al
000077A1  0000              add [eax],al
000077A3  0000              add [eax],al
000077A5  0000              add [eax],al
000077A7  0000              add [eax],al
000077A9  0000              add [eax],al
000077AB  0000              add [eax],al
000077AD  0000              add [eax],al
000077AF  0000              add [eax],al
000077B1  0000              add [eax],al
000077B3  0000              add [eax],al
000077B5  0000              add [eax],al
000077B7  0000              add [eax],al
000077B9  0000              add [eax],al
000077BB  0000              add [eax],al
000077BD  0000              add [eax],al
000077BF  0000              add [eax],al
000077C1  0000              add [eax],al
000077C3  0000              add [eax],al
000077C5  0000              add [eax],al
000077C7  0000              add [eax],al
000077C9  0000              add [eax],al
000077CB  0000              add [eax],al
000077CD  0000              add [eax],al
000077CF  0000              add [eax],al
000077D1  0000              add [eax],al
000077D3  0000              add [eax],al
000077D5  0000              add [eax],al
000077D7  0000              add [eax],al
000077D9  0000              add [eax],al
000077DB  0000              add [eax],al
000077DD  0000              add [eax],al
000077DF  0000              add [eax],al
000077E1  0000              add [eax],al
000077E3  0000              add [eax],al
000077E5  0000              add [eax],al
000077E7  0000              add [eax],al
000077E9  0000              add [eax],al
000077EB  0000              add [eax],al
000077ED  0000              add [eax],al
000077EF  0000              add [eax],al
000077F1  0000              add [eax],al
000077F3  0000              add [eax],al
000077F5  0000              add [eax],al
000077F7  0000              add [eax],al
000077F9  0000              add [eax],al
000077FB  0000              add [eax],al
000077FD  0000              add [eax],al
000077FF  0000              add [eax],al
00007801  0000              add [eax],al
00007803  0000              add [eax],al
00007805  0000              add [eax],al
00007807  0000              add [eax],al
00007809  0000              add [eax],al
0000780B  0000              add [eax],al
0000780D  0000              add [eax],al
0000780F  0000              add [eax],al
00007811  0000              add [eax],al
00007813  0000              add [eax],al
00007815  0000              add [eax],al
00007817  0000              add [eax],al
00007819  0000              add [eax],al
0000781B  0000              add [eax],al
0000781D  0000              add [eax],al
0000781F  0000              add [eax],al
00007821  0000              add [eax],al
00007823  0000              add [eax],al
00007825  0000              add [eax],al
00007827  0000              add [eax],al
00007829  0000              add [eax],al
0000782B  0000              add [eax],al
0000782D  0000              add [eax],al
0000782F  0000              add [eax],al
00007831  0000              add [eax],al
00007833  0000              add [eax],al
00007835  0000              add [eax],al
00007837  0000              add [eax],al
00007839  0000              add [eax],al
0000783B  0000              add [eax],al
0000783D  0000              add [eax],al
0000783F  0000              add [eax],al
00007841  0000              add [eax],al
00007843  0000              add [eax],al
00007845  0000              add [eax],al
00007847  0000              add [eax],al
00007849  0000              add [eax],al
0000784B  0000              add [eax],al
0000784D  0000              add [eax],al
0000784F  0000              add [eax],al
00007851  0000              add [eax],al
00007853  0000              add [eax],al
00007855  0000              add [eax],al
00007857  0000              add [eax],al
00007859  0000              add [eax],al
0000785B  0000              add [eax],al
0000785D  0000              add [eax],al
0000785F  0000              add [eax],al
00007861  0000              add [eax],al
00007863  0000              add [eax],al
00007865  0000              add [eax],al
00007867  0000              add [eax],al
00007869  0000              add [eax],al
0000786B  0000              add [eax],al
0000786D  0000              add [eax],al
0000786F  0000              add [eax],al
00007871  0000              add [eax],al
00007873  0000              add [eax],al
00007875  0000              add [eax],al
00007877  0000              add [eax],al
00007879  0000              add [eax],al
0000787B  0000              add [eax],al
0000787D  0000              add [eax],al
0000787F  0000              add [eax],al
00007881  0000              add [eax],al
00007883  0000              add [eax],al
00007885  0000              add [eax],al
00007887  0000              add [eax],al
00007889  0000              add [eax],al
0000788B  0000              add [eax],al
0000788D  0000              add [eax],al
0000788F  0000              add [eax],al
00007891  0000              add [eax],al
00007893  0000              add [eax],al
00007895  0000              add [eax],al
00007897  0000              add [eax],al
00007899  0000              add [eax],al
0000789B  0000              add [eax],al
0000789D  0000              add [eax],al
0000789F  0000              add [eax],al
000078A1  0000              add [eax],al
000078A3  0000              add [eax],al
000078A5  0000              add [eax],al
000078A7  0000              add [eax],al
000078A9  0000              add [eax],al
000078AB  0000              add [eax],al
000078AD  0000              add [eax],al
000078AF  0000              add [eax],al
000078B1  0000              add [eax],al
000078B3  0000              add [eax],al
000078B5  0000              add [eax],al
000078B7  0000              add [eax],al
000078B9  0000              add [eax],al
000078BB  0000              add [eax],al
000078BD  0000              add [eax],al
000078BF  0000              add [eax],al
000078C1  0000              add [eax],al
000078C3  0000              add [eax],al
000078C5  0000              add [eax],al
000078C7  0000              add [eax],al
000078C9  0000              add [eax],al
000078CB  0000              add [eax],al
000078CD  0000              add [eax],al
000078CF  0000              add [eax],al
000078D1  0000              add [eax],al
000078D3  0000              add [eax],al
000078D5  0000              add [eax],al
000078D7  0000              add [eax],al
000078D9  0000              add [eax],al
000078DB  0000              add [eax],al
000078DD  0000              add [eax],al
000078DF  0000              add [eax],al
000078E1  0000              add [eax],al
000078E3  0000              add [eax],al
000078E5  0000              add [eax],al
000078E7  0000              add [eax],al
000078E9  0000              add [eax],al
000078EB  0000              add [eax],al
000078ED  0000              add [eax],al
000078EF  0000              add [eax],al
000078F1  0000              add [eax],al
000078F3  0000              add [eax],al
000078F5  0000              add [eax],al
000078F7  0000              add [eax],al
000078F9  0000              add [eax],al
000078FB  0000              add [eax],al
000078FD  0000              add [eax],al
000078FF  0000              add [eax],al
00007901  0000              add [eax],al
00007903  0000              add [eax],al
00007905  0000              add [eax],al
00007907  0000              add [eax],al
00007909  0000              add [eax],al
0000790B  0000              add [eax],al
0000790D  0000              add [eax],al
0000790F  0000              add [eax],al
00007911  0000              add [eax],al
00007913  0000              add [eax],al
00007915  0000              add [eax],al
00007917  0000              add [eax],al
00007919  0000              add [eax],al
0000791B  0000              add [eax],al
0000791D  0000              add [eax],al
0000791F  0000              add [eax],al
00007921  0000              add [eax],al
00007923  0000              add [eax],al
00007925  0000              add [eax],al
00007927  0000              add [eax],al
00007929  0000              add [eax],al
0000792B  0000              add [eax],al
0000792D  0000              add [eax],al
0000792F  0000              add [eax],al
00007931  0000              add [eax],al
00007933  0000              add [eax],al
00007935  0000              add [eax],al
00007937  0000              add [eax],al
00007939  0000              add [eax],al
0000793B  0000              add [eax],al
0000793D  0000              add [eax],al
0000793F  0000              add [eax],al
00007941  0000              add [eax],al
00007943  0000              add [eax],al
00007945  0000              add [eax],al
00007947  0000              add [eax],al
00007949  0000              add [eax],al
0000794B  0000              add [eax],al
0000794D  0000              add [eax],al
0000794F  0000              add [eax],al
00007951  0000              add [eax],al
00007953  0000              add [eax],al
00007955  0000              add [eax],al
00007957  0000              add [eax],al
00007959  0000              add [eax],al
0000795B  0000              add [eax],al
0000795D  0000              add [eax],al
0000795F  0000              add [eax],al
00007961  0000              add [eax],al
00007963  0000              add [eax],al
00007965  0000              add [eax],al
00007967  0000              add [eax],al
00007969  0000              add [eax],al
0000796B  0000              add [eax],al
0000796D  0000              add [eax],al
0000796F  0000              add [eax],al
00007971  0000              add [eax],al
00007973  0000              add [eax],al
00007975  0000              add [eax],al
00007977  0000              add [eax],al
00007979  0000              add [eax],al
0000797B  0000              add [eax],al
0000797D  0000              add [eax],al
0000797F  0000              add [eax],al
00007981  0000              add [eax],al
00007983  0000              add [eax],al
00007985  0000              add [eax],al
00007987  0000              add [eax],al
00007989  0000              add [eax],al
0000798B  0000              add [eax],al
0000798D  0000              add [eax],al
0000798F  0000              add [eax],al
00007991  0000              add [eax],al
00007993  0000              add [eax],al
00007995  0000              add [eax],al
00007997  0000              add [eax],al
00007999  0000              add [eax],al
0000799B  0000              add [eax],al
0000799D  0000              add [eax],al
0000799F  0000              add [eax],al
000079A1  0000              add [eax],al
000079A3  0000              add [eax],al
000079A5  0000              add [eax],al
000079A7  0000              add [eax],al
000079A9  0000              add [eax],al
000079AB  0000              add [eax],al
000079AD  0000              add [eax],al
000079AF  0000              add [eax],al
000079B1  0000              add [eax],al
000079B3  0000              add [eax],al
000079B5  0000              add [eax],al
000079B7  0000              add [eax],al
000079B9  0000              add [eax],al
000079BB  0000              add [eax],al
000079BD  0000              add [eax],al
000079BF  0000              add [eax],al
000079C1  0000              add [eax],al
000079C3  0000              add [eax],al
000079C5  0000              add [eax],al
000079C7  0000              add [eax],al
000079C9  0000              add [eax],al
000079CB  0000              add [eax],al
000079CD  0000              add [eax],al
000079CF  0000              add [eax],al
000079D1  0000              add [eax],al
000079D3  0000              add [eax],al
000079D5  0000              add [eax],al
000079D7  0000              add [eax],al
000079D9  0000              add [eax],al
000079DB  0000              add [eax],al
000079DD  0000              add [eax],al
000079DF  0000              add [eax],al
000079E1  0000              add [eax],al
000079E3  0000              add [eax],al
000079E5  0000              add [eax],al
000079E7  0000              add [eax],al
000079E9  0000              add [eax],al
000079EB  0000              add [eax],al
000079ED  0000              add [eax],al
000079EF  0000              add [eax],al
000079F1  0000              add [eax],al
000079F3  0000              add [eax],al
000079F5  0000              add [eax],al
000079F7  0000              add [eax],al
000079F9  0000              add [eax],al
000079FB  0000              add [eax],al
000079FD  0000              add [eax],al
000079FF  0000              add [eax],al
00007A01  0000              add [eax],al
00007A03  0000              add [eax],al
00007A05  0000              add [eax],al
00007A07  0000              add [eax],al
00007A09  0000              add [eax],al
00007A0B  0000              add [eax],al
00007A0D  0000              add [eax],al
00007A0F  0000              add [eax],al
00007A11  0000              add [eax],al
00007A13  0000              add [eax],al
00007A15  0000              add [eax],al
00007A17  0000              add [eax],al
00007A19  0000              add [eax],al
00007A1B  0000              add [eax],al
00007A1D  0000              add [eax],al
00007A1F  0000              add [eax],al
00007A21  0000              add [eax],al
00007A23  0000              add [eax],al
00007A25  0000              add [eax],al
00007A27  0000              add [eax],al
00007A29  0000              add [eax],al
00007A2B  0000              add [eax],al
00007A2D  0000              add [eax],al
00007A2F  0000              add [eax],al
00007A31  0000              add [eax],al
00007A33  0000              add [eax],al
00007A35  0000              add [eax],al
00007A37  0000              add [eax],al
00007A39  0000              add [eax],al
00007A3B  0000              add [eax],al
00007A3D  0000              add [eax],al
00007A3F  0000              add [eax],al
00007A41  0000              add [eax],al
00007A43  0000              add [eax],al
00007A45  0000              add [eax],al
00007A47  0000              add [eax],al
00007A49  0000              add [eax],al
00007A4B  0000              add [eax],al
00007A4D  0000              add [eax],al
00007A4F  0000              add [eax],al
00007A51  0000              add [eax],al
00007A53  0000              add [eax],al
00007A55  0000              add [eax],al
00007A57  0000              add [eax],al
00007A59  0000              add [eax],al
00007A5B  0000              add [eax],al
00007A5D  0000              add [eax],al
00007A5F  0000              add [eax],al
00007A61  0000              add [eax],al
00007A63  0000              add [eax],al
00007A65  0000              add [eax],al
00007A67  0000              add [eax],al
00007A69  0000              add [eax],al
00007A6B  0000              add [eax],al
00007A6D  0000              add [eax],al
00007A6F  0000              add [eax],al
00007A71  0000              add [eax],al
00007A73  0000              add [eax],al
00007A75  0000              add [eax],al
00007A77  0000              add [eax],al
00007A79  0000              add [eax],al
00007A7B  0000              add [eax],al
00007A7D  0000              add [eax],al
00007A7F  0000              add [eax],al
00007A81  0000              add [eax],al
00007A83  0000              add [eax],al
00007A85  0000              add [eax],al
00007A87  0000              add [eax],al
00007A89  0000              add [eax],al
00007A8B  0000              add [eax],al
00007A8D  0000              add [eax],al
00007A8F  0000              add [eax],al
00007A91  0000              add [eax],al
00007A93  0000              add [eax],al
00007A95  0000              add [eax],al
00007A97  0000              add [eax],al
00007A99  0000              add [eax],al
00007A9B  0000              add [eax],al
00007A9D  0000              add [eax],al
00007A9F  0000              add [eax],al
00007AA1  0000              add [eax],al
00007AA3  0000              add [eax],al
00007AA5  0000              add [eax],al
00007AA7  0000              add [eax],al
00007AA9  0000              add [eax],al
00007AAB  0000              add [eax],al
00007AAD  0000              add [eax],al
00007AAF  0000              add [eax],al
00007AB1  0000              add [eax],al
00007AB3  0000              add [eax],al
00007AB5  0000              add [eax],al
00007AB7  0000              add [eax],al
00007AB9  0000              add [eax],al
00007ABB  0000              add [eax],al
00007ABD  0000              add [eax],al
00007ABF  0000              add [eax],al
00007AC1  0000              add [eax],al
00007AC3  0000              add [eax],al
00007AC5  0000              add [eax],al
00007AC7  0000              add [eax],al
00007AC9  0000              add [eax],al
00007ACB  0000              add [eax],al
00007ACD  0000              add [eax],al
00007ACF  0000              add [eax],al
00007AD1  0000              add [eax],al
00007AD3  0000              add [eax],al
00007AD5  0000              add [eax],al
00007AD7  0000              add [eax],al
00007AD9  0000              add [eax],al
00007ADB  0000              add [eax],al
00007ADD  0000              add [eax],al
00007ADF  0000              add [eax],al
00007AE1  0000              add [eax],al
00007AE3  0000              add [eax],al
00007AE5  0000              add [eax],al
00007AE7  0000              add [eax],al
00007AE9  0000              add [eax],al
00007AEB  0000              add [eax],al
00007AED  0000              add [eax],al
00007AEF  0000              add [eax],al
00007AF1  0000              add [eax],al
00007AF3  0000              add [eax],al
00007AF5  0000              add [eax],al
00007AF7  0000              add [eax],al
00007AF9  0000              add [eax],al
00007AFB  0000              add [eax],al
00007AFD  0000              add [eax],al
00007AFF  0000              add [eax],al
00007B01  0000              add [eax],al
00007B03  0000              add [eax],al
00007B05  0000              add [eax],al
00007B07  0000              add [eax],al
00007B09  0000              add [eax],al
00007B0B  0000              add [eax],al
00007B0D  0000              add [eax],al
00007B0F  0000              add [eax],al
00007B11  0000              add [eax],al
00007B13  0000              add [eax],al
00007B15  0000              add [eax],al
00007B17  0000              add [eax],al
00007B19  0000              add [eax],al
00007B1B  0000              add [eax],al
00007B1D  0000              add [eax],al
00007B1F  0000              add [eax],al
00007B21  0000              add [eax],al
00007B23  0000              add [eax],al
00007B25  0000              add [eax],al
00007B27  0000              add [eax],al
00007B29  0000              add [eax],al
00007B2B  0000              add [eax],al
00007B2D  0000              add [eax],al
00007B2F  0000              add [eax],al
00007B31  0000              add [eax],al
00007B33  0000              add [eax],al
00007B35  0000              add [eax],al
00007B37  0000              add [eax],al
00007B39  0000              add [eax],al
00007B3B  0000              add [eax],al
00007B3D  0000              add [eax],al
00007B3F  0000              add [eax],al
00007B41  0000              add [eax],al
00007B43  0000              add [eax],al
00007B45  0000              add [eax],al
00007B47  0000              add [eax],al
00007B49  0000              add [eax],al
00007B4B  0000              add [eax],al
00007B4D  0000              add [eax],al
00007B4F  0000              add [eax],al
00007B51  0000              add [eax],al
00007B53  0000              add [eax],al
00007B55  0000              add [eax],al
00007B57  0000              add [eax],al
00007B59  0000              add [eax],al
00007B5B  0000              add [eax],al
00007B5D  0000              add [eax],al
00007B5F  0000              add [eax],al
00007B61  0000              add [eax],al
00007B63  0000              add [eax],al
00007B65  0000              add [eax],al
00007B67  0000              add [eax],al
00007B69  0000              add [eax],al
00007B6B  0000              add [eax],al
00007B6D  0000              add [eax],al
00007B6F  0000              add [eax],al
00007B71  0000              add [eax],al
00007B73  0000              add [eax],al
00007B75  0000              add [eax],al
00007B77  0000              add [eax],al
00007B79  0000              add [eax],al
00007B7B  0000              add [eax],al
00007B7D  0000              add [eax],al
00007B7F  0000              add [eax],al
00007B81  0000              add [eax],al
00007B83  0000              add [eax],al
00007B85  0000              add [eax],al
00007B87  0000              add [eax],al
00007B89  0000              add [eax],al
00007B8B  0000              add [eax],al
00007B8D  0000              add [eax],al
00007B8F  0000              add [eax],al
00007B91  0000              add [eax],al
00007B93  0000              add [eax],al
00007B95  0000              add [eax],al
00007B97  0000              add [eax],al
00007B99  0000              add [eax],al
00007B9B  0000              add [eax],al
00007B9D  0000              add [eax],al
00007B9F  0000              add [eax],al
00007BA1  0000              add [eax],al
00007BA3  0000              add [eax],al
00007BA5  0000              add [eax],al
00007BA7  0000              add [eax],al
00007BA9  0000              add [eax],al
00007BAB  0000              add [eax],al
00007BAD  0000              add [eax],al
00007BAF  0000              add [eax],al
00007BB1  0000              add [eax],al
00007BB3  0000              add [eax],al
00007BB5  0000              add [eax],al
00007BB7  0000              add [eax],al
00007BB9  0000              add [eax],al
00007BBB  0000              add [eax],al
00007BBD  0000              add [eax],al
00007BBF  0000              add [eax],al
00007BC1  0000              add [eax],al
00007BC3  0000              add [eax],al
00007BC5  0000              add [eax],al
00007BC7  0000              add [eax],al
00007BC9  0000              add [eax],al
00007BCB  0000              add [eax],al
00007BCD  0000              add [eax],al
00007BCF  0000              add [eax],al
00007BD1  0000              add [eax],al
00007BD3  0000              add [eax],al
00007BD5  0000              add [eax],al
00007BD7  0000              add [eax],al
00007BD9  0000              add [eax],al
00007BDB  0000              add [eax],al
00007BDD  0000              add [eax],al
00007BDF  0000              add [eax],al
00007BE1  0000              add [eax],al
00007BE3  0000              add [eax],al
00007BE5  0000              add [eax],al
00007BE7  0000              add [eax],al
00007BE9  0000              add [eax],al
00007BEB  0000              add [eax],al
00007BED  0000              add [eax],al
00007BEF  0000              add [eax],al
00007BF1  0000              add [eax],al
00007BF3  0000              add [eax],al
00007BF5  0000              add [eax],al
00007BF7  0000              add [eax],al
00007BF9  0000              add [eax],al
00007BFB  0000              add [eax],al
00007BFD  0000              add [eax],al
00007BFF  0000              add [eax],al
00007C01  0000              add [eax],al
00007C03  0000              add [eax],al
00007C05  0000              add [eax],al
00007C07  0000              add [eax],al
00007C09  0000              add [eax],al
00007C0B  0000              add [eax],al
00007C0D  0000              add [eax],al
00007C0F  0000              add [eax],al
00007C11  0000              add [eax],al
00007C13  0000              add [eax],al
00007C15  0000              add [eax],al
00007C17  0000              add [eax],al
00007C19  0000              add [eax],al
00007C1B  0000              add [eax],al
00007C1D  0000              add [eax],al
00007C1F  0000              add [eax],al
00007C21  0000              add [eax],al
00007C23  0000              add [eax],al
00007C25  0000              add [eax],al
00007C27  0000              add [eax],al
00007C29  0000              add [eax],al
00007C2B  0000              add [eax],al
00007C2D  0000              add [eax],al
00007C2F  0000              add [eax],al
00007C31  0000              add [eax],al
00007C33  0000              add [eax],al
00007C35  0000              add [eax],al
00007C37  0000              add [eax],al
00007C39  0000              add [eax],al
00007C3B  0000              add [eax],al
00007C3D  0000              add [eax],al
00007C3F  0000              add [eax],al
00007C41  0000              add [eax],al
00007C43  0000              add [eax],al
00007C45  0000              add [eax],al
00007C47  0000              add [eax],al
00007C49  0000              add [eax],al
00007C4B  0000              add [eax],al
00007C4D  0000              add [eax],al
00007C4F  0000              add [eax],al
00007C51  0000              add [eax],al
00007C53  0000              add [eax],al
00007C55  0000              add [eax],al
00007C57  0000              add [eax],al
00007C59  0000              add [eax],al
00007C5B  0000              add [eax],al
00007C5D  0000              add [eax],al
00007C5F  0000              add [eax],al
00007C61  0000              add [eax],al
00007C63  0000              add [eax],al
00007C65  0000              add [eax],al
00007C67  0000              add [eax],al
00007C69  0000              add [eax],al
00007C6B  0000              add [eax],al
00007C6D  0000              add [eax],al
00007C6F  0000              add [eax],al
00007C71  0000              add [eax],al
00007C73  0000              add [eax],al
00007C75  0000              add [eax],al
00007C77  0000              add [eax],al
00007C79  0000              add [eax],al
00007C7B  0000              add [eax],al
00007C7D  0000              add [eax],al
00007C7F  0000              add [eax],al
00007C81  0000              add [eax],al
00007C83  0000              add [eax],al
00007C85  0000              add [eax],al
00007C87  0000              add [eax],al
00007C89  0000              add [eax],al
00007C8B  0000              add [eax],al
00007C8D  0000              add [eax],al
00007C8F  0000              add [eax],al
00007C91  0000              add [eax],al
00007C93  0000              add [eax],al
00007C95  0000              add [eax],al
00007C97  0000              add [eax],al
00007C99  0000              add [eax],al
00007C9B  0000              add [eax],al
00007C9D  0000              add [eax],al
00007C9F  0000              add [eax],al
00007CA1  0000              add [eax],al
00007CA3  0000              add [eax],al
00007CA5  0000              add [eax],al
00007CA7  0000              add [eax],al
00007CA9  0000              add [eax],al
00007CAB  0000              add [eax],al
00007CAD  0000              add [eax],al
00007CAF  0000              add [eax],al
00007CB1  0000              add [eax],al
00007CB3  0000              add [eax],al
00007CB5  0000              add [eax],al
00007CB7  0000              add [eax],al
00007CB9  0000              add [eax],al
00007CBB  0000              add [eax],al
00007CBD  0000              add [eax],al
00007CBF  0000              add [eax],al
00007CC1  0000              add [eax],al
00007CC3  0000              add [eax],al
00007CC5  0000              add [eax],al
00007CC7  0000              add [eax],al
00007CC9  0000              add [eax],al
00007CCB  0000              add [eax],al
00007CCD  0000              add [eax],al
00007CCF  0000              add [eax],al
00007CD1  0000              add [eax],al
00007CD3  0000              add [eax],al
00007CD5  0000              add [eax],al
00007CD7  0000              add [eax],al
00007CD9  0000              add [eax],al
00007CDB  0000              add [eax],al
00007CDD  0000              add [eax],al
00007CDF  0000              add [eax],al
00007CE1  0000              add [eax],al
00007CE3  0000              add [eax],al
00007CE5  0000              add [eax],al
00007CE7  0000              add [eax],al
00007CE9  0000              add [eax],al
00007CEB  0000              add [eax],al
00007CED  0000              add [eax],al
00007CEF  0000              add [eax],al
00007CF1  0000              add [eax],al
00007CF3  0000              add [eax],al
00007CF5  0000              add [eax],al
00007CF7  0000              add [eax],al
00007CF9  0000              add [eax],al
00007CFB  0000              add [eax],al
00007CFD  0000              add [eax],al
00007CFF  0000              add [eax],al
00007D01  0000              add [eax],al
00007D03  0000              add [eax],al
00007D05  0000              add [eax],al
00007D07  0000              add [eax],al
00007D09  0000              add [eax],al
00007D0B  0000              add [eax],al
00007D0D  0000              add [eax],al
00007D0F  0000              add [eax],al
00007D11  0000              add [eax],al
00007D13  0000              add [eax],al
00007D15  0000              add [eax],al
00007D17  0000              add [eax],al
00007D19  0000              add [eax],al
00007D1B  0000              add [eax],al
00007D1D  0000              add [eax],al
00007D1F  0000              add [eax],al
00007D21  0000              add [eax],al
00007D23  0000              add [eax],al
00007D25  0000              add [eax],al
00007D27  0000              add [eax],al
00007D29  0000              add [eax],al
00007D2B  0000              add [eax],al
00007D2D  0000              add [eax],al
00007D2F  0000              add [eax],al
00007D31  0000              add [eax],al
00007D33  0000              add [eax],al
00007D35  0000              add [eax],al
00007D37  0000              add [eax],al
00007D39  0000              add [eax],al
00007D3B  0000              add [eax],al
00007D3D  0000              add [eax],al
00007D3F  0000              add [eax],al
00007D41  0000              add [eax],al
00007D43  0000              add [eax],al
00007D45  0000              add [eax],al
00007D47  0000              add [eax],al
00007D49  0000              add [eax],al
00007D4B  0000              add [eax],al
00007D4D  0000              add [eax],al
00007D4F  0000              add [eax],al
00007D51  0000              add [eax],al
00007D53  0000              add [eax],al
00007D55  0000              add [eax],al
00007D57  0000              add [eax],al
00007D59  0000              add [eax],al
00007D5B  0000              add [eax],al
00007D5D  0000              add [eax],al
00007D5F  0000              add [eax],al
00007D61  0000              add [eax],al
00007D63  0000              add [eax],al
00007D65  0000              add [eax],al
00007D67  0000              add [eax],al
00007D69  0000              add [eax],al
00007D6B  0000              add [eax],al
00007D6D  0000              add [eax],al
00007D6F  0000              add [eax],al
00007D71  0000              add [eax],al
00007D73  0000              add [eax],al
00007D75  0000              add [eax],al
00007D77  0000              add [eax],al
00007D79  0000              add [eax],al
00007D7B  0000              add [eax],al
00007D7D  0000              add [eax],al
00007D7F  0000              add [eax],al
00007D81  0000              add [eax],al
00007D83  0000              add [eax],al
00007D85  0000              add [eax],al
00007D87  0000              add [eax],al
00007D89  0000              add [eax],al
00007D8B  0000              add [eax],al
00007D8D  0000              add [eax],al
00007D8F  0000              add [eax],al
00007D91  0000              add [eax],al
00007D93  0000              add [eax],al
00007D95  0000              add [eax],al
00007D97  0000              add [eax],al
00007D99  0000              add [eax],al
00007D9B  0000              add [eax],al
00007D9D  0000              add [eax],al
00007D9F  0000              add [eax],al
00007DA1  0000              add [eax],al
00007DA3  0000              add [eax],al
00007DA5  0000              add [eax],al
00007DA7  0000              add [eax],al
00007DA9  0000              add [eax],al
00007DAB  0000              add [eax],al
00007DAD  0000              add [eax],al
00007DAF  0000              add [eax],al
00007DB1  0000              add [eax],al
00007DB3  0000              add [eax],al
00007DB5  0000              add [eax],al
00007DB7  0000              add [eax],al
00007DB9  0000              add [eax],al
00007DBB  0000              add [eax],al
00007DBD  0000              add [eax],al
00007DBF  0000              add [eax],al
00007DC1  0000              add [eax],al
00007DC3  0000              add [eax],al
00007DC5  0000              add [eax],al
00007DC7  0000              add [eax],al
00007DC9  0000              add [eax],al
00007DCB  0000              add [eax],al
00007DCD  0000              add [eax],al
00007DCF  0000              add [eax],al
00007DD1  0000              add [eax],al
00007DD3  0000              add [eax],al
00007DD5  0000              add [eax],al
00007DD7  0000              add [eax],al
00007DD9  0000              add [eax],al
00007DDB  0000              add [eax],al
00007DDD  0000              add [eax],al
00007DDF  0000              add [eax],al
00007DE1  0000              add [eax],al
00007DE3  0000              add [eax],al
00007DE5  0000              add [eax],al
00007DE7  0000              add [eax],al
00007DE9  0000              add [eax],al
00007DEB  0000              add [eax],al
00007DED  0000              add [eax],al
00007DEF  0000              add [eax],al
00007DF1  0000              add [eax],al
00007DF3  0000              add [eax],al
00007DF5  0000              add [eax],al
00007DF7  0000              add [eax],al
00007DF9  0000              add [eax],al
00007DFB  0000              add [eax],al
00007DFD  0000              add [eax],al
00007DFF  0000              add [eax],al
00007E01  0000              add [eax],al
00007E03  0000              add [eax],al
00007E05  0000              add [eax],al
00007E07  0000              add [eax],al
00007E09  0000              add [eax],al
00007E0B  0000              add [eax],al
00007E0D  0000              add [eax],al
00007E0F  0000              add [eax],al
00007E11  0000              add [eax],al
00007E13  0000              add [eax],al
00007E15  0000              add [eax],al
00007E17  0000              add [eax],al
00007E19  0000              add [eax],al
00007E1B  0000              add [eax],al
00007E1D  0000              add [eax],al
00007E1F  0000              add [eax],al
00007E21  0000              add [eax],al
00007E23  0000              add [eax],al
00007E25  0000              add [eax],al
00007E27  0000              add [eax],al
00007E29  0000              add [eax],al
00007E2B  0000              add [eax],al
00007E2D  0000              add [eax],al
00007E2F  0000              add [eax],al
00007E31  0000              add [eax],al
00007E33  0000              add [eax],al
00007E35  0000              add [eax],al
00007E37  0000              add [eax],al
00007E39  0000              add [eax],al
00007E3B  0000              add [eax],al
00007E3D  0000              add [eax],al
00007E3F  0000              add [eax],al
00007E41  0000              add [eax],al
00007E43  0000              add [eax],al
00007E45  0000              add [eax],al
00007E47  0000              add [eax],al
00007E49  0000              add [eax],al
00007E4B  0000              add [eax],al
00007E4D  0000              add [eax],al
00007E4F  0000              add [eax],al
00007E51  0000              add [eax],al
00007E53  0000              add [eax],al
00007E55  0000              add [eax],al
00007E57  0000              add [eax],al
00007E59  0000              add [eax],al
00007E5B  0000              add [eax],al
00007E5D  0000              add [eax],al
00007E5F  0000              add [eax],al
00007E61  0000              add [eax],al
00007E63  0000              add [eax],al
00007E65  0000              add [eax],al
00007E67  0000              add [eax],al
00007E69  0000              add [eax],al
00007E6B  0000              add [eax],al
00007E6D  0000              add [eax],al
00007E6F  0000              add [eax],al
00007E71  0000              add [eax],al
00007E73  0000              add [eax],al
00007E75  0000              add [eax],al
00007E77  0000              add [eax],al
00007E79  0000              add [eax],al
00007E7B  0000              add [eax],al
00007E7D  0000              add [eax],al
00007E7F  0000              add [eax],al
00007E81  0000              add [eax],al
00007E83  0000              add [eax],al
00007E85  0000              add [eax],al
00007E87  0000              add [eax],al
00007E89  0000              add [eax],al
00007E8B  0000              add [eax],al
00007E8D  0000              add [eax],al
00007E8F  0000              add [eax],al
00007E91  0000              add [eax],al
00007E93  0000              add [eax],al
00007E95  0000              add [eax],al
00007E97  0000              add [eax],al
00007E99  0000              add [eax],al
00007E9B  0000              add [eax],al
00007E9D  0000              add [eax],al
00007E9F  0000              add [eax],al
00007EA1  0000              add [eax],al
00007EA3  0000              add [eax],al
00007EA5  0000              add [eax],al
00007EA7  0000              add [eax],al
00007EA9  0000              add [eax],al
00007EAB  0000              add [eax],al
00007EAD  0000              add [eax],al
00007EAF  0000              add [eax],al
00007EB1  0000              add [eax],al
00007EB3  0000              add [eax],al
00007EB5  0000              add [eax],al
00007EB7  0000              add [eax],al
00007EB9  0000              add [eax],al
00007EBB  0000              add [eax],al
00007EBD  0000              add [eax],al
00007EBF  0000              add [eax],al
00007EC1  0000              add [eax],al
00007EC3  0000              add [eax],al
00007EC5  0000              add [eax],al
00007EC7  0000              add [eax],al
00007EC9  0000              add [eax],al
00007ECB  0000              add [eax],al
00007ECD  0000              add [eax],al
00007ECF  0000              add [eax],al
00007ED1  0000              add [eax],al
00007ED3  0000              add [eax],al
00007ED5  0000              add [eax],al
00007ED7  0000              add [eax],al
00007ED9  0000              add [eax],al
00007EDB  0000              add [eax],al
00007EDD  0000              add [eax],al
00007EDF  0000              add [eax],al
00007EE1  0000              add [eax],al
00007EE3  0000              add [eax],al
00007EE5  0000              add [eax],al
00007EE7  0000              add [eax],al
00007EE9  0000              add [eax],al
00007EEB  0000              add [eax],al
00007EED  0000              add [eax],al
00007EEF  0000              add [eax],al
00007EF1  0000              add [eax],al
00007EF3  0000              add [eax],al
00007EF5  0000              add [eax],al
00007EF7  0000              add [eax],al
00007EF9  0000              add [eax],al
00007EFB  0000              add [eax],al
00007EFD  0000              add [eax],al
00007EFF  0000              add [eax],al
00007F01  0000              add [eax],al
00007F03  0000              add [eax],al
00007F05  0000              add [eax],al
00007F07  0000              add [eax],al
00007F09  0000              add [eax],al
00007F0B  0000              add [eax],al
00007F0D  0000              add [eax],al
00007F0F  0000              add [eax],al
00007F11  0000              add [eax],al
00007F13  0000              add [eax],al
00007F15  0000              add [eax],al
00007F17  0000              add [eax],al
00007F19  0000              add [eax],al
00007F1B  0000              add [eax],al
00007F1D  0000              add [eax],al
00007F1F  0000              add [eax],al
00007F21  0000              add [eax],al
00007F23  0000              add [eax],al
00007F25  0000              add [eax],al
00007F27  0000              add [eax],al
00007F29  0000              add [eax],al
00007F2B  0000              add [eax],al
00007F2D  0000              add [eax],al
00007F2F  0000              add [eax],al
00007F31  0000              add [eax],al
00007F33  0000              add [eax],al
00007F35  0000              add [eax],al
00007F37  0000              add [eax],al
00007F39  0000              add [eax],al
00007F3B  0000              add [eax],al
00007F3D  0000              add [eax],al
00007F3F  0000              add [eax],al
00007F41  0000              add [eax],al
00007F43  0000              add [eax],al
00007F45  0000              add [eax],al
00007F47  0000              add [eax],al
00007F49  0000              add [eax],al
00007F4B  0000              add [eax],al
00007F4D  0000              add [eax],al
00007F4F  0000              add [eax],al
00007F51  0000              add [eax],al
00007F53  0000              add [eax],al
00007F55  0000              add [eax],al
00007F57  0000              add [eax],al
00007F59  0000              add [eax],al
00007F5B  0000              add [eax],al
00007F5D  0000              add [eax],al
00007F5F  0000              add [eax],al
00007F61  0000              add [eax],al
00007F63  0000              add [eax],al
00007F65  0000              add [eax],al
00007F67  0000              add [eax],al
00007F69  0000              add [eax],al
00007F6B  0000              add [eax],al
00007F6D  0000              add [eax],al
00007F6F  0000              add [eax],al
00007F71  0000              add [eax],al
00007F73  0000              add [eax],al
00007F75  0000              add [eax],al
00007F77  0000              add [eax],al
00007F79  0000              add [eax],al
00007F7B  0000              add [eax],al
00007F7D  0000              add [eax],al
00007F7F  0000              add [eax],al
00007F81  0000              add [eax],al
00007F83  0000              add [eax],al
00007F85  0000              add [eax],al
00007F87  0000              add [eax],al
00007F89  0000              add [eax],al
00007F8B  0000              add [eax],al
00007F8D  0000              add [eax],al
00007F8F  0000              add [eax],al
00007F91  0000              add [eax],al
00007F93  0000              add [eax],al
00007F95  0000              add [eax],al
00007F97  0000              add [eax],al
00007F99  0000              add [eax],al
00007F9B  0000              add [eax],al
00007F9D  0000              add [eax],al
00007F9F  0000              add [eax],al
00007FA1  0000              add [eax],al
00007FA3  0000              add [eax],al
00007FA5  0000              add [eax],al
00007FA7  0000              add [eax],al
00007FA9  0000              add [eax],al
00007FAB  0000              add [eax],al
00007FAD  0000              add [eax],al
00007FAF  0000              add [eax],al
00007FB1  0000              add [eax],al
00007FB3  0000              add [eax],al
00007FB5  0000              add [eax],al
00007FB7  0000              add [eax],al
00007FB9  0000              add [eax],al
00007FBB  0000              add [eax],al
00007FBD  0000              add [eax],al
00007FBF  0000              add [eax],al
00007FC1  0000              add [eax],al
00007FC3  0000              add [eax],al
00007FC5  0000              add [eax],al
00007FC7  0000              add [eax],al
00007FC9  0000              add [eax],al
00007FCB  0000              add [eax],al
00007FCD  0000              add [eax],al
00007FCF  0000              add [eax],al
00007FD1  0000              add [eax],al
00007FD3  0000              add [eax],al
00007FD5  0000              add [eax],al
00007FD7  0000              add [eax],al
00007FD9  0000              add [eax],al
00007FDB  0000              add [eax],al
00007FDD  0000              add [eax],al
00007FDF  0000              add [eax],al
00007FE1  0000              add [eax],al
00007FE3  0000              add [eax],al
00007FE5  0000              add [eax],al
00007FE7  0000              add [eax],al
00007FE9  0000              add [eax],al
00007FEB  0000              add [eax],al
00007FED  0000              add [eax],al
00007FEF  0000              add [eax],al
00007FF1  0000              add [eax],al
00007FF3  0000              add [eax],al
00007FF5  0000              add [eax],al
00007FF7  0000              add [eax],al
00007FF9  0000              add [eax],al
00007FFB  0000              add [eax],al
00007FFD  0000              add [eax],al
00007FFF  0030              add [eax],dh
00008001  3132              xor [edx],esi
00008003  33343536373839    xor esi,[esi+0x39383736]
0000800A  61                popad
0000800B  626364            bound esp,[ebx+0x64]
0000800E  65660000          o16 add [gs:eax],al
00008012  0000              add [eax],al
00008014  60                pushad
00008015  16                push ss
00008016  1000              adc [eax],al
00008018  0017              add [edi],dl
0000801A  1000              adc [eax],al
0000801C  0017              add [edi],dl
0000801E  1000              adc [eax],al
00008020  0017              add [edi],dl
00008022  1000              adc [eax],al
00008024  0017              add [edi],dl
00008026  1000              adc [eax],al
00008028  0017              add [edi],dl
0000802A  1000              adc [eax],al
0000802C  0017              add [edi],dl
0000802E  1000              adc [eax],al
00008030  0017              add [edi],dl
00008032  1000              adc [eax],al
00008034  0017              add [edi],dl
00008036  1000              adc [eax],al
00008038  0017              add [edi],dl
0000803A  1000              adc [eax],al
0000803C  0017              add [edi],dl
0000803E  1000              adc [eax],al
00008040  0017              add [edi],dl
00008042  1000              adc [eax],al
00008044  0017              add [edi],dl
00008046  1000              adc [eax],al
00008048  0017              add [edi],dl
0000804A  1000              adc [eax],al
0000804C  0017              add [edi],dl
0000804E  1000              adc [eax],al
00008050  0017              add [edi],dl
00008052  1000              adc [eax],al
00008054  0017              add [edi],dl
00008056  1000              adc [eax],al
00008058  0017              add [edi],dl
0000805A  1000              adc [eax],al
0000805C  0017              add [edi],dl
0000805E  1000              adc [eax],al
00008060  0017              add [edi],dl
00008062  1000              adc [eax],al
00008064  0017              add [edi],dl
00008066  1000              adc [eax],al
00008068  0017              add [edi],dl
0000806A  1000              adc [eax],al
0000806C  0017              add [edi],dl
0000806E  1000              adc [eax],al
00008070  0017              add [edi],dl
00008072  1000              adc [eax],al
00008074  0017              add [edi],dl
00008076  1000              adc [eax],al
00008078  0017              add [edi],dl
0000807A  1000              adc [eax],al
0000807C  0017              add [edi],dl
0000807E  1000              adc [eax],al
00008080  0017              add [edi],dl
00008082  1000              adc [eax],al
00008084  0017              add [edi],dl
00008086  1000              adc [eax],al
00008088  0017              add [edi],dl
0000808A  1000              adc [eax],al
0000808C  0017              add [edi],dl
0000808E  1000              adc [eax],al
00008090  40                inc eax
00008091  16                push ss
00008092  1000              adc [eax],al
00008094  0017              add [edi],dl
00008096  1000              adc [eax],al
00008098  0017              add [edi],dl
0000809A  1000              adc [eax],al
0000809C  0017              add [edi],dl
0000809E  1000              adc [eax],al
000080A0  0017              add [edi],dl
000080A2  1000              adc [eax],al
000080A4  40                inc eax
000080A5  16                push ss
000080A6  1000              adc [eax],al
000080A8  0017              add [edi],dl
000080AA  1000              adc [eax],al
000080AC  0017              add [edi],dl
000080AE  1000              adc [eax],al
000080B0  0017              add [edi],dl
000080B2  1000              adc [eax],al
000080B4  0017              add [edi],dl
000080B6  1000              adc [eax],al
000080B8  0017              add [edi],dl
000080BA  1000              adc [eax],al
000080BC  0017              add [edi],dl
000080BE  1000              adc [eax],al
000080C0  0017              add [edi],dl
000080C2  1000              adc [eax],al
000080C4  0017              add [edi],dl
000080C6  1000              adc [eax],al
000080C8  0017              add [edi],dl
000080CA  1000              adc [eax],al
000080CC  0017              add [edi],dl
000080CE  1000              adc [eax],al
000080D0  0017              add [edi],dl
000080D2  1000              adc [eax],al
000080D4  0017              add [edi],dl
000080D6  1000              adc [eax],al
000080D8  0017              add [edi],dl
000080DA  1000              adc [eax],al
000080DC  0017              add [edi],dl
000080DE  1000              adc [eax],al
000080E0  0017              add [edi],dl
000080E2  1000              adc [eax],al
000080E4  0017              add [edi],dl
000080E6  1000              adc [eax],al
000080E8  0017              add [edi],dl
000080EA  1000              adc [eax],al
000080EC  0017              add [edi],dl
000080EE  1000              adc [eax],al
000080F0  0017              add [edi],dl
000080F2  1000              adc [eax],al
000080F4  0017              add [edi],dl
000080F6  1000              adc [eax],al
000080F8  0017              add [edi],dl
000080FA  1000              adc [eax],al
000080FC  0017              add [edi],dl
000080FE  1000              adc [eax],al
00008100  0017              add [edi],dl
00008102  1000              adc [eax],al
00008104  0017              add [edi],dl
00008106  1000              adc [eax],al
00008108  40                inc eax
00008109  16                push ss
0000810A  1000              adc [eax],al
0000810C  2016              and [esi],dl
0000810E  1000              adc [eax],al
00008110  0016              add [esi],dl
00008112  1000              adc [eax],al
00008114  0017              add [edi],dl
00008116  1000              adc [eax],al
00008118  80151000001710    adc byte [dword 0x17000010],0x10
0000811F  0000              add [eax],al
00008121  17                pop ss
00008122  1000              adc [eax],al
00008124  0016              add [esi],dl
00008126  1000              adc [eax],al
00008128  0017              add [edi],dl
0000812A  1000              adc [eax],al
0000812C  0017              add [edi],dl
0000812E  1000              adc [eax],al
00008130  0017              add [edi],dl
00008132  1000              adc [eax],al
00008134  0017              add [edi],dl
00008136  1000              adc [eax],al
00008138  0017              add [edi],dl
0000813A  1000              adc [eax],al
0000813C  0017              add [edi],dl
0000813E  1000              adc [eax],al
00008140  50                push eax
00008141  1510000017        adc eax,0x17000010
00008146  1000              adc [eax],al
00008148  0017              add [edi],dl
0000814A  1000              adc [eax],al
0000814C  801610            adc byte [esi],0x10
0000814F  0000              add [eax],al
00008151  17                pop ss
00008152  1000              adc [eax],al
00008154  0017              add [edi],dl
00008156  1000              adc [eax],al
00008158  0017              add [edi],dl
0000815A  1000              adc [eax],al
0000815C  0017              add [edi],dl
0000815E  1000              adc [eax],al
00008160  50                push eax
00008161  151000596F        adc eax,0x6f590010
00008166  7520              jnz 0x8188
00008168  63616E            arpl [ecx+0x6e],sp
0000816B  27                daa
0000816C  7420              jz 0x818e
0000816E  646F              fs outsd
00008170  20746861          and [eax+ebp*2+0x61],dh
00008174  7421              jz 0x8197
00008176  007374            add [ebx+0x74],dh
00008179  61                popad
0000817A  7274              jc 0x81f0
0000817C  2100              and [eax],eax
0000817E  637230            arpl [edx+0x30],si
00008181  3A20              cmp ah,[eax]
00008183  007373            add [ebx+0x73],dh
00008186  3A20              cmp ah,[eax]
00008188  0064733A          add [ebx+esi*2+0x3a],ah
0000818C  2000              and [eax],al
0000818E  63733A            arpl [ebx+0x3a],si
00008191  2000              and [eax],al
00008193  2D2D3E3A20        sub eax,0x203a3e2d
00008198  7C25              jl 0x81bf
0000819A  647C20            fs jl 0x81bd
0000819D  7C25              jl 0x81c4
0000819F  647C0A            fs jl 0x81ac
000081A2  006764            add [edi+0x64],ah
000081A5  743A              jz 0x81e1
000081A7  202578202578      and [dword 0x78252078],ah
000081AD  0A00              or al,[eax]
000081AF  6964743A20257820  imul esp,[esp+esi*2+0x3a],dword 0x20782520
000081B7  25780A0069        and eax,0x69000a78
000081BC  7372              jnc 0x8230
000081BE  5F                pop edi
000081BF  313A              xor [edx],edi
000081C1  202578202578      and [dword 0x78252078],ah
000081C7  0A00              or al,[eax]
000081C9  7369              jnc 0x8234
000081CB  7A65              jpe 0x8232
000081CD  6F                outsd
000081CE  66284944          o16 sub [ecx+0x44],cl
000081D2  54                push esp
000081D3  45                inc ebp
000081D4  6E                outsb
000081D5  7472              jz 0x8249
000081D7  7929              jns 0x8202
000081D9  3A20              cmp ah,[eax]
000081DB  25640A0065        and eax,0x65000a64
000081E0  666C              o16 insb
000081E2  61                popad
000081E3  67733A            jnc 0x8220
000081E6  2025780A0065      and [dword 0x65000a78],ah
000081EC  666C              o16 insb
000081EE  61                popad
000081EF  67733A            jnc 0x822c
000081F2  207B0A            and [ebx+0xa],bh
000081F5  006361            add [ebx+0x61],ah
000081F8  7272              jc 0x826c
000081FA  7900              jns 0x81fc
000081FC  0925733A2025      or [dword 0x25203a73],esp
00008202  640A00            or al,[fs:eax]
00008205  7061              jo 0x8268
00008207  7269              jc 0x8272
00008209  7479              jz 0x8284
0000820B  006164            add [ecx+0x64],ah
0000820E  6A75              push byte +0x75
00008210  7374              jnc 0x8286
00008212  007A65            add [edx+0x65],bh
00008215  726F              jc 0x8286
00008217  007369            add [ebx+0x69],dh
0000821A  676E              a16 outsb
0000821C  00747261          add [edx+esi*2+0x61],dh
00008220  7000              jo 0x8222
00008222  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
00008229  7074              jo 0x829f
0000822B  7300              jnc 0x822d
0000822D  646972656374696F  imul esi,[fs:edx+0x65],dword 0x6f697463
00008235  6E                outsb
00008236  006F76            add [edi+0x76],ch
00008239  657266            gs jc 0x82a2
0000823C  6C                insb
0000823D  6F                outsd
0000823E  7700              ja 0x8240
00008240  696F706C006E65    imul ebp,[edi+0x70],dword 0x656e006c
00008247  7374              jnc 0x82bd
00008249  65645F            fs pop edi
0000824C  7461              jz 0x82af
0000824E  736B              jnc 0x82bb
00008250  007265            add [edx+0x65],dh
00008253  7375              jnc 0x82ca
00008255  6D                insd
00008256  65007669          add [gs:esi+0x69],dh
0000825A  7274              jc 0x82d0
0000825C  7561              jnz 0x82bf
0000825E  6C                insb
0000825F  5F                pop edi
00008260  3830              cmp [eax],dh
00008262  3836              cmp [esi],dh
00008264  5F                pop edi
00008265  6D                insd
00008266  6F                outsd
00008267  646500616C        add [gs:ecx+0x6c],ah
0000826C  69676E6D656E74    imul esp,[edi+0x6e],dword 0x746e656d
00008273  5F                pop edi
00008274  636865            arpl [eax+0x65],bp
00008277  636B00            arpl [ebx+0x0],bp
0000827A  7669              jna 0x82e5
0000827C  7274              jc 0x82f2
0000827E  7561              jnz 0x82e1
00008280  6C                insb
00008281  5F                pop edi
00008282  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
00008289  7074              jo 0x82ff
0000828B  007669            add [esi+0x69],dh
0000828E  7274              jc 0x8304
00008290  7561              jnz 0x82f3
00008292  6C                insb
00008293  5F                pop edi
00008294  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
0000829B  7074              jo 0x8311
0000829D  5F                pop edi
0000829E  7065              jo 0x8305
000082A0  6E                outsb
000082A1  64696E6700696400  imul ebp,[fs:esi+0x67],dword 0x646900
000082A9  7D0A              jnl 0x82b5
000082AB  00543A20          add [edx+edi+0x20],dl
000082AF  2578202578        and eax,0x78252078
000082B4  0A00              or al,[eax]
000082B6  4B                dec ebx
000082B7  65726E            gs jc 0x8328
000082BA  656C              gs insb
000082BC  207374            and [ebx+0x74],dh
000082BF  61                popad
000082C0  7274              jc 0x8336
000082C2  65640A00          or al,[fs:eax]
000082C6  7369              jnc 0x8331
000082C8  7A65              jpe 0x832f
000082CA  6F                outsd
000082CB  6628546173        o16 sub [ecx+0x73],dl
000082D0  6B293A            imul ebp,[ecx],byte +0x3a
000082D3  2025640A0073      and [dword 0x73000a64],ah
000082D9  7061              jo 0x833c
000082DB  776E              ja 0x834b
000082DD  65640A00          or al,[fs:eax]
000082E1  7469              jz 0x834c
000082E3  636B31            arpl [ebx+0x31],bp
000082E6  3A20              cmp ah,[eax]
000082E8  25640A0068        and eax,0x68000a64
000082ED  6974206D6178696D  imul esi,[eax+0x6d],dword 0x6d697861
000082F5  756D              jnz 0x8364
000082F7  20746173          and [ecx+0x73],dh
000082FB  6B206C            imul esp,[eax],byte +0x6c
000082FE  696D6974007961    imul ebp,[ebp+0x69],dword 0x61790074
00008305  792E              jns 0x8335
00008307  2020              and [eax],ah
00008309  6B5F746F          imul ebx,[edi+0x74],byte +0x6f
0000830D  7461              jz 0x8370
0000830F  6C                insb
00008310  7461              jz 0x8373
00008312  736B              jnc 0x837f
00008314  733A              jnc 0x8350
00008316  2025640A0061      and [dword 0x61000a64],ah
0000831C  6464723A          fs jc 0x835a
00008320  202564202578      and [dword 0x78252064],ah
00008326  0A00              or al,[eax]
00008328  46                inc esi
00008329  61                popad
0000832A  696C656420746F20  imul ebp,[ebp+0x64],dword 0x206f7420
00008332  61                popad
00008333  6C                insb
00008334  6C                insb
00008335  6F                outsd
00008336  636174            arpl [ecx+0x74],sp
00008339  6564207374        and [fs:ebx+0x74],dh
0000833E  61                popad
0000833F  636B00            arpl [ebx+0x0],bp
00008342  4B                dec ebx
00008343  45                inc ebp
00008344  52                push edx
00008345  4E                dec esi
00008346  45                inc ebp
00008347  4C                dec esp
00008348  204552            and [ebp+0x52],al
0000834B  52                push edx
0000834C  4F                dec edi
0000834D  52                push edx
0000834E  3A25643A2025      cmp ah,[dword 0x25203a64]
00008354  730A              jnc 0x8360
00008356  005157            add [ecx+0x57],dl
00008359  45                inc ebp
0000835A  52                push edx
0000835B  54                push esp
0000835C  59                pop ecx
0000835D  55                push ebp
0000835E  49                dec ecx
0000835F  4F                dec edi
00008360  50                push eax
00008361  5B                pop ebx
00008362  5D                pop ebp
00008363  004153            add [ecx+0x53],al
00008366  44                inc esp
00008367  46                inc esi
00008368  47                inc edi
00008369  48                dec eax
0000836A  4A                dec edx
0000836B  4B                dec ebx
0000836C  4C                dec esp
0000836D  3B27              cmp esp,[edi]
0000836F  005A58            add [edx+0x58],bl
00008372  43                inc ebx
00008373  56                push esi
00008374  42                inc edx
00008375  4E                dec esi
00008376  4D                dec ebp
00008377  2C2E              sub al,0x2e
00008379  2F                das
0000837A  0031              add [ecx],dh
0000837C  3233              xor dh,[ebx]
0000837E  3435              xor al,0x35
00008380  3637              ss aaa
00008382  3839              cmp [ecx],bh
00008384  302D3D001400      xor [dword 0x14003d],ch
0000838A  0000              add [eax],al
0000838C  0000              add [eax],al
0000838E  0000              add [eax],al
00008390  017A52            add [edx+0x52],edi
00008393  0001              add [ecx],al
00008395  7C08              jl 0x839f
00008397  011B              add [ebx],ebx
00008399  0C04              or al,0x4
0000839B  0488              add al,0x88
0000839D  0100              add [eax],eax
0000839F  0030              add [eax],dh
000083A1  0000              add [eax],al
000083A3  001C00            add [eax+eax],bl
000083A6  0000              add [eax],al
000083A8  D81CFF            fcomp dword [edi+edi*8]
000083AB  FF7700            push dword [edi+0x0]
000083AE  0000              add [eax],al
000083B0  00410E            add [ecx+0xe],al
000083B3  088702410E0C      or [edi+0xc0e4102],al
000083B9  8603              xchg al,[ebx]
000083BB  41                inc ecx
000083BC  0E                push cs
000083BD  108304430E20      adc [ebx+0x200e4304],al
000083C3  026D0E            add ch,[ebp+0xe]
000083C6  1041C3            adc [ecx-0x3d],al
000083C9  0E                push cs
000083CA  0C41              or al,0x41
000083CC  C6                db 0xc6
000083CD  0E                push cs
000083CE  0841C7            or [ecx-0x39],al
000083D1  0E                push cs
000083D2  0400              add al,0x0
000083D4  3800              cmp [eax],al
000083D6  0000              add [eax],al
000083D8  50                push eax
000083D9  0000              add [eax],al
000083DB  00241DFFFFA100    add [ebx+0xa1ffff],ah
000083E2  0000              add [eax],al
000083E4  00410E            add [ecx+0xe],al
000083E7  088602410E0C      or [esi+0xc0e4102],al
000083ED  830343            add dword [ebx],byte +0x43
000083F0  0E                push cs
000083F1  10650E            adc [ebp+0xe],ah
000083F4  18450E            sbb [ebp+0xe],al
000083F7  1C42              sbb al,0x42
000083F9  0E                push cs
000083FA  204B0E            and [ebx+0xe],cl
000083FD  1002              adc [edx],al
000083FF  50                push eax
00008400  0A0E              or cl,[esi]
00008402  0C41              or al,0x41
00008404  C3                ret
00008405  0E                push cs
00008406  0841C6            or [ecx-0x3a],al
00008409  0E                push cs
0000840A  0442              add al,0x42
0000840C  0B00              or eax,[eax]
0000840E  0000              add [eax],al
00008410  1800              sbb [eax],al
00008412  0000              add [eax],al
00008414  8C00              mov [eax],es
00008416  0000              add [eax],al
00008418  98                cwde
00008419  1DFFFF5300        sbb eax,0x53ffff
0000841E  0000              add [eax],al
00008420  00410E            add [ecx+0xe],al
00008423  0883020251C3      or [ebx-0x3caefdfe],al
00008429  0E                push cs
0000842A  0400              add al,0x0
0000842C  7000              jo 0x842e
0000842E  0000              add [eax],al
00008430  A800              test al,0x0
00008432  0000              add [eax],al
00008434  DC1DFFFF0301      fcomp qword [dword 0x103ffff]
0000843A  0000              add [eax],al
0000843C  00410E            add [ecx+0xe],al
0000843F  088302430E24      or [ebx+0x240e4302],al
00008445  42                inc edx
00008446  0E                push cs
00008447  28420E            sub [edx+0xe],al
0000844A  2C45              sub al,0x45
0000844C  0E                push cs
0000844D  30480E            xor [eax+0xe],cl
00008450  2442              and al,0x42
00008452  0E                push cs
00008453  28420E            sub [edx+0xe],al
00008456  2C45              sub al,0x45
00008458  0E                push cs
00008459  305E0E            xor [esi+0xe],bl
0000845C  2C41              sub al,0x41
0000845E  0E                push cs
0000845F  28450E            sub [ebp+0xe],al
00008462  2C45              sub al,0x45
00008464  0E                push cs
00008465  305E0E            xor [esi+0xe],bl
00008468  2C41              sub al,0x41
0000846A  0E                push cs
0000846B  28410E            sub [ecx+0xe],al
0000846E  2C45              sub al,0x45
00008470  0E                push cs
00008471  305E0E            xor [esi+0xe],bl
00008474  2C41              sub al,0x41
00008476  0E                push cs
00008477  28410E            sub [ecx+0xe],al
0000847A  2C45              sub al,0x45
0000847C  0E                push cs
0000847D  305E0E            xor [esi+0xe],bl
00008480  2C41              sub al,0x41
00008482  0E                push cs
00008483  28410E            sub [ecx+0xe],al
00008486  2C45              sub al,0x45
00008488  0E                push cs
00008489  305E0E            xor [esi+0xe],bl
0000848C  2C41              sub al,0x41
0000848E  0E                push cs
0000848F  28410E            sub [ecx+0xe],al
00008492  2C45              sub al,0x45
00008494  0E                push cs
00008495  30660E            xor [esi+0xe],ah
00008498  0841C3            or [ecx-0x3d],al
0000849B  0E                push cs
0000849C  0400              add al,0x0
0000849E  0000              add [eax],al
000084A0  2800              sub [eax],al
000084A2  0000              add [eax],al
000084A4  1C01              sbb al,0x1
000084A6  0000              add [eax],al
000084A8  781E              js 0x84c8
000084AA  FF                db 0xff
000084AB  FF5200            call dword [edx+0x0]
000084AE  0000              add [eax],al
000084B0  00430E            add [ebx+0xe],al
000084B3  1C45              sbb al,0x45
000084B5  0E                push cs
000084B6  20480E            and [eax+0xe],cl
000084B9  106B0E            adc [ebx+0xe],ch
000084BC  1441              adc al,0x41
000084BE  0E                push cs
000084BF  18410E            sbb [ecx+0xe],al
000084C2  1C45              sbb al,0x45
000084C4  0E                push cs
000084C5  204E0E            and [esi+0xe],cl
000084C8  1000              adc [eax],al
000084CA  0000              add [eax],al
000084CC  1C02              sbb al,0x2
000084CE  0000              add [eax],al
000084D0  48                dec eax
000084D1  0100              add [eax],eax
000084D3  00AC1EFFFF3506    add [esi+ebx+0x635ffff],ch
000084DA  0000              add [eax],al
000084DC  00410E            add [ecx+0xe],al
000084DF  088502410E0C      or [ebp+0xc0e4102],al
000084E5  8703              xchg eax,[ebx]
000084E7  41                inc ecx
000084E8  0E                push cs
000084E9  108604410E14      adc [esi+0x140e4104],al
000084EF  8305430E5C450E    add dword [dword 0x455c0e43],byte +0xe
000084F6  60                pushad
000084F7  02EA              add ch,dl
000084F9  0E                push cs
000084FA  5C                pop esp
000084FB  45                inc ebp
000084FC  0E                push cs
000084FD  60                pushad
000084FE  02A30E54410E      add ah,[ebx+0xe41540e]
00008504  58                pop eax
00008505  41                inc ecx
00008506  0E                push cs
00008507  5C                pop esp
00008508  45                inc ebp
00008509  0E                push cs
0000850A  60                pushad
0000850B  48                dec eax
0000850C  0E                push cs
0000850D  54                push esp
0000850E  45                inc ebp
0000850F  0E                push cs
00008510  58                pop eax
00008511  41                inc ecx
00008512  0E                push cs
00008513  5C                pop esp
00008514  45                inc ebp
00008515  0E                push cs
00008516  60                pushad
00008517  4F                dec edi
00008518  0E                push cs
00008519  50                push eax
0000851A  47                inc edi
0000851B  0E                push cs
0000851C  58                pop eax
0000851D  44                inc esp
0000851E  0E                push cs
0000851F  5C                pop esp
00008520  4B                dec ebx
00008521  0E                push cs
00008522  60                pushad
00008523  4B                dec ebx
00008524  0E                push cs
00008525  644B              fs dec ebx
00008527  0E                push cs
00008528  684B0E6C48        push dword 0x486c0e4b
0000852D  0E                push cs
0000852E  704B              jo 0x857b
00008530  0E                push cs
00008531  744B              jz 0x857e
00008533  0E                push cs
00008534  784B              js 0x8581
00008536  0E                push cs
00008537  7C48              jl 0x8581
00008539  0E                push cs
0000853A  800145            add byte [ecx],0x45
0000853D  0E                push cs
0000853E  8401              test [ecx],al
00008540  45                inc ebp
00008541  0E                push cs
00008542  8801              mov [ecx],al
00008544  45                inc ebp
00008545  0E                push cs
00008546  8C01              mov [ecx],es
00008548  45                inc ebp
00008549  0E                push cs
0000854A  90                nop
0000854B  01480E            add [eax+0xe],ecx
0000854E  50                push eax
0000854F  4D                dec ebp
00008550  0E                push cs
00008551  5C                pop esp
00008552  45                inc ebp
00008553  0E                push cs
00008554  60                pushad
00008555  46                inc esi
00008556  0E                push cs
00008557  5C                pop esp
00008558  41                inc ecx
00008559  0E                push cs
0000855A  58                pop eax
0000855B  45                inc ebp
0000855C  0E                push cs
0000855D  5C                pop esp
0000855E  41                inc ecx
0000855F  0E                push cs
00008560  60                pushad
00008561  49                dec ecx
00008562  0E                push cs
00008563  6444              fs inc esp
00008565  0E                push cs
00008566  68440E6C45        push dword 0x456c0e44
0000856B  0E                push cs
0000856C  704B              jo 0x85b9
0000856E  0E                push cs
0000856F  58                pop eax
00008570  41                inc ecx
00008571  0E                push cs
00008572  5C                pop esp
00008573  41                inc ecx
00008574  0E                push cs
00008575  60                pushad
00008576  49                dec ecx
00008577  0E                push cs
00008578  6444              fs inc esp
0000857A  0E                push cs
0000857B  68440E6C45        push dword 0x456c0e44
00008580  0E                push cs
00008581  704B              jo 0x85ce
00008583  0E                push cs
00008584  58                pop eax
00008585  44                inc esp
00008586  0E                push cs
00008587  5C                pop esp
00008588  41                inc ecx
00008589  0E                push cs
0000858A  60                pushad
0000858B  49                dec ecx
0000858C  0E                push cs
0000858D  6444              fs inc esp
0000858F  0E                push cs
00008590  68440E6C45        push dword 0x456c0e44
00008595  0E                push cs
00008596  7048              jo 0x85e0
00008598  0E                push cs
00008599  58                pop eax
0000859A  41                inc ecx
0000859B  0E                push cs
0000859C  5C                pop esp
0000859D  41                inc ecx
0000859E  0E                push cs
0000859F  60                pushad
000085A0  49                dec ecx
000085A1  0E                push cs
000085A2  6444              fs inc esp
000085A4  0E                push cs
000085A5  68440E6C45        push dword 0x456c0e44
000085AA  0E                push cs
000085AB  7048              jo 0x85f5
000085AD  0E                push cs
000085AE  5C                pop esp
000085AF  45                inc ebp
000085B0  0E                push cs
000085B1  60                pushad
000085B2  50                push eax
000085B3  0E                push cs
000085B4  54                push esp
000085B5  45                inc ebp
000085B6  0E                push cs
000085B7  58                pop eax
000085B8  52                push edx
000085B9  0E                push cs
000085BA  5C                pop esp
000085BB  45                inc ebp
000085BC  0E                push cs
000085BD  60                pushad
000085BE  4F                dec edi
000085BF  0E                push cs
000085C0  54                push esp
000085C1  41                inc ecx
000085C2  0E                push cs
000085C3  58                pop eax
000085C4  50                push eax
000085C5  0E                push cs
000085C6  5C                pop esp
000085C7  49                dec ecx
000085C8  0E                push cs
000085C9  60                pushad
000085CA  49                dec ecx
000085CB  0E                push cs
000085CC  6449              fs dec ecx
000085CE  0E                push cs
000085CF  684C0E6C41        push dword 0x416c0e4c
000085D4  0E                push cs
000085D5  7048              jo 0x861f
000085D7  0E                push cs
000085D8  7448              jz 0x8622
000085DA  0E                push cs
000085DB  7848              js 0x8625
000085DD  0E                push cs
000085DE  7C45              jl 0x8625
000085E0  0E                push cs
000085E1  80014F            add byte [ecx],0x4f
000085E4  0E                push cs
000085E5  54                push esp
000085E6  45                inc ebp
000085E7  0E                push cs
000085E8  58                pop eax
000085E9  4F                dec edi
000085EA  0E                push cs
000085EB  5C                pop esp
000085EC  45                inc ebp
000085ED  0E                push cs
000085EE  60                pushad
000085EF  46                inc esi
000085F0  0E                push cs
000085F1  5C                pop esp
000085F2  41                inc ecx
000085F3  0E                push cs
000085F4  58                pop eax
000085F5  42                inc edx
000085F6  0E                push cs
000085F7  5C                pop esp
000085F8  45                inc ebp
000085F9  0E                push cs
000085FA  60                pushad
000085FB  4B                dec ebx
000085FC  0E                push cs
000085FD  5C                pop esp
000085FE  41                inc ecx
000085FF  0E                push cs
00008600  58                pop eax
00008601  4D                dec ebp
00008602  0E                push cs
00008603  5C                pop esp
00008604  45                inc ebp
00008605  0E                push cs
00008606  60                pushad
00008607  56                push esi
00008608  0E                push cs
00008609  54                push esp
0000860A  44                inc esp
0000860B  0E                push cs
0000860C  58                pop eax
0000860D  45                inc ebp
0000860E  0E                push cs
0000860F  5C                pop esp
00008610  45                inc ebp
00008611  0E                push cs
00008612  60                pushad
00008613  4A                dec edx
00008614  0E                push cs
00008615  54                push esp
00008616  47                inc edi
00008617  0E                push cs
00008618  58                pop eax
00008619  45                inc ebp
0000861A  0E                push cs
0000861B  5C                pop esp
0000861C  45                inc ebp
0000861D  0E                push cs
0000861E  60                pushad
0000861F  4A                dec edx
00008620  0E                push cs
00008621  54                push esp
00008622  47                inc edi
00008623  0E                push cs
00008624  58                pop eax
00008625  45                inc ebp
00008626  0E                push cs
00008627  5C                pop esp
00008628  45                inc ebp
00008629  0E                push cs
0000862A  60                pushad
0000862B  4A                dec edx
0000862C  0E                push cs
0000862D  54                push esp
0000862E  47                inc edi
0000862F  0E                push cs
00008630  58                pop eax
00008631  45                inc ebp
00008632  0E                push cs
00008633  5C                pop esp
00008634  45                inc ebp
00008635  0E                push cs
00008636  60                pushad
00008637  4A                dec edx
00008638  0E                push cs
00008639  54                push esp
0000863A  47                inc edi
0000863B  0E                push cs
0000863C  58                pop eax
0000863D  45                inc ebp
0000863E  0E                push cs
0000863F  5C                pop esp
00008640  45                inc ebp
00008641  0E                push cs
00008642  60                pushad
00008643  4A                dec edx
00008644  0E                push cs
00008645  54                push esp
00008646  47                inc edi
00008647  0E                push cs
00008648  58                pop eax
00008649  45                inc ebp
0000864A  0E                push cs
0000864B  5C                pop esp
0000864C  45                inc ebp
0000864D  0E                push cs
0000864E  60                pushad
0000864F  4A                dec edx
00008650  0E                push cs
00008651  54                push esp
00008652  47                inc edi
00008653  0E                push cs
00008654  58                pop eax
00008655  45                inc ebp
00008656  0E                push cs
00008657  5C                pop esp
00008658  45                inc ebp
00008659  0E                push cs
0000865A  60                pushad
0000865B  4A                dec edx
0000865C  0E                push cs
0000865D  54                push esp
0000865E  47                inc edi
0000865F  0E                push cs
00008660  58                pop eax
00008661  45                inc ebp
00008662  0E                push cs
00008663  5C                pop esp
00008664  45                inc ebp
00008665  0E                push cs
00008666  60                pushad
00008667  4A                dec edx
00008668  0E                push cs
00008669  54                push esp
0000866A  47                inc edi
0000866B  0E                push cs
0000866C  58                pop eax
0000866D  45                inc ebp
0000866E  0E                push cs
0000866F  5C                pop esp
00008670  45                inc ebp
00008671  0E                push cs
00008672  60                pushad
00008673  4A                dec edx
00008674  0E                push cs
00008675  54                push esp
00008676  47                inc edi
00008677  0E                push cs
00008678  58                pop eax
00008679  45                inc ebp
0000867A  0E                push cs
0000867B  5C                pop esp
0000867C  45                inc ebp
0000867D  0E                push cs
0000867E  60                pushad
0000867F  4A                dec edx
00008680  0E                push cs
00008681  54                push esp
00008682  47                inc edi
00008683  0E                push cs
00008684  58                pop eax
00008685  45                inc ebp
00008686  0E                push cs
00008687  5C                pop esp
00008688  45                inc ebp
00008689  0E                push cs
0000868A  60                pushad
0000868B  4A                dec edx
0000868C  0E                push cs
0000868D  54                push esp
0000868E  47                inc edi
0000868F  0E                push cs
00008690  58                pop eax
00008691  45                inc ebp
00008692  0E                push cs
00008693  5C                pop esp
00008694  45                inc ebp
00008695  0E                push cs
00008696  60                pushad
00008697  4A                dec edx
00008698  0E                push cs
00008699  54                push esp
0000869A  47                inc edi
0000869B  0E                push cs
0000869C  58                pop eax
0000869D  45                inc ebp
0000869E  0E                push cs
0000869F  5C                pop esp
000086A0  45                inc ebp
000086A1  0E                push cs
000086A2  60                pushad
000086A3  4A                dec edx
000086A4  0E                push cs
000086A5  54                push esp
000086A6  47                inc edi
000086A7  0E                push cs
000086A8  58                pop eax
000086A9  45                inc ebp
000086AA  0E                push cs
000086AB  5C                pop esp
000086AC  45                inc ebp
000086AD  0E                push cs
000086AE  60                pushad
000086AF  4A                dec edx
000086B0  0E                push cs
000086B1  54                push esp
000086B2  47                inc edi
000086B3  0E                push cs
000086B4  58                pop eax
000086B5  45                inc ebp
000086B6  0E                push cs
000086B7  5C                pop esp
000086B8  45                inc ebp
000086B9  0E                push cs
000086BA  60                pushad
000086BB  4A                dec edx
000086BC  0E                push cs
000086BD  54                push esp
000086BE  47                inc edi
000086BF  0E                push cs
000086C0  58                pop eax
000086C1  45                inc ebp
000086C2  0E                push cs
000086C3  5C                pop esp
000086C4  45                inc ebp
000086C5  0E                push cs
000086C6  60                pushad
000086C7  4A                dec edx
000086C8  0E                push cs
000086C9  54                push esp
000086CA  47                inc edi
000086CB  0E                push cs
000086CC  58                pop eax
000086CD  45                inc ebp
000086CE  0E                push cs
000086CF  5C                pop esp
000086D0  45                inc ebp
000086D1  0E                push cs
000086D2  60                pushad
000086D3  59                pop ecx
000086D4  0E                push cs
000086D5  54                push esp
000086D6  45                inc ebp
000086D7  0E                push cs
000086D8  58                pop eax
000086D9  41                inc ecx
000086DA  0E                push cs
000086DB  5C                pop esp
000086DC  45                inc ebp
000086DD  0E                push cs
000086DE  60                pushad
000086DF  4E                dec esi
000086E0  0E                push cs
000086E1  50                push eax
000086E2  630E              arpl [esi],cx
000086E4  5C                pop esp
000086E5  48                dec eax
000086E6  0E                push cs
000086E7  60                pushad
000086E8  48                dec eax
000086E9  0E                push cs
000086EA  50                push eax
000086EB  0010              add [eax],dl
000086ED  0000              add [eax],al
000086EF  006803            add [eax+0x3],ch
000086F2  0000              add [eax],al
000086F4  CC                int3
000086F5  22FF              and bh,bh
000086F7  FF2B              jmp dword far [ebx]
000086F9  0000              add [eax],al
000086FB  0000              add [eax],al
000086FD  0000              add [eax],al
000086FF  0010              add [eax],dl
00008701  0000              add [eax],al
00008703  007C0300          add [ebx+eax+0x0],bh
00008707  00E8              add al,ch
00008709  22FF              and bh,bh
0000870B  FF0B              dec dword [ebx]
0000870D  0000              add [eax],al
0000870F  0000              add [eax],al
00008711  0000              add [eax],al
00008713  001C00            add [eax+eax],bl
00008716  0000              add [eax],al
00008718  90                nop
00008719  0300              add eax,[eax]
0000871B  00E4              add ah,ah
0000871D  22FF              and bh,bh
0000871F  FF4800            dec dword [eax+0x0]
00008722  0000              add [eax],al
00008724  00430E            add [ebx+0xe],al
00008727  105C0E1C          adc [esi+ecx+0x1c],bl
0000872B  45                inc ebp
0000872C  0E                push cs
0000872D  20630E            and [ebx+0xe],ah
00008730  0400              add al,0x0
00008732  0000              add [eax],al
00008734  1800              sbb [eax],al
00008736  0000              add [eax],al
00008738  B003              mov al,0x3
0000873A  0000              add [eax],al
0000873C  1423              adc al,0x23
0000873E  FF                db 0xff
0000873F  FF0C00            dec dword [eax+eax]
00008742  0000              add [eax],al
00008744  00430E            add [ebx+0xe],al
00008747  18420E            sbb [edx+0xe],al
0000874A  1C42              sbb al,0x42
0000874C  0E                push cs
0000874D  2000              and [eax],al
0000874F  003400            add [eax+eax],dh
00008752  0000              add [eax],al
00008754  CC                int3
00008755  0300              add eax,[eax]
00008757  0008              add [eax],cl
00008759  23FF              and edi,edi
0000875B  FF6700            jmp dword [edi+0x0]
0000875E  0000              add [eax],al
00008760  00430E            add [ebx+0xe],al
00008763  10480E            adc [eax+0xe],cl
00008766  18420E            sbb [edx+0xe],al
00008769  1C45              sbb al,0x45
0000876B  0E                push cs
0000876C  20480E            and [eax+0xe],cl
0000876F  1445              adc al,0x45
00008771  0E                push cs
00008772  18420E            sbb [edx+0xe],al
00008775  1C42              sbb al,0x42
00008777  0E                push cs
00008778  20580E            and [eax+0xe],bl
0000877B  10560E            adc [esi+0xe],dl
0000877E  18410E            sbb [ecx+0xe],al
00008781  1C45              sbb al,0x45
00008783  0E                push cs
00008784  204E0E            and [esi+0xe],cl
00008787  102C00            adc [eax+eax],ch
0000878A  0000              add [eax],al
0000878C  0404              add al,0x4
0000878E  0000              add [eax],al
00008790  40                inc eax
00008791  23FF              and edi,edi
00008793  FFB100000000      push dword [ecx+0x0]
00008799  43                inc ebx
0000879A  0E                push cs
0000879B  1459              adc al,0x59
0000879D  0E                push cs
0000879E  18420E            sbb [edx+0xe],al
000087A1  1C45              sbb al,0x45
000087A3  0E                push cs
000087A4  205C0E14          and [esi+ecx+0x14],bl
000087A8  45                inc ebp
000087A9  0E                push cs
000087AA  18420E            sbb [edx+0xe],al
000087AD  1C45              sbb al,0x45
000087AF  0E                push cs
000087B0  2002              and [edx],al
000087B2  61                popad
000087B3  0E                push cs
000087B4  0400              add al,0x0
000087B6  0000              add [eax],al
000087B8  1000              adc [eax],al
000087BA  0000              add [eax],al
000087BC  3404              xor al,0x4
000087BE  0000              add [eax],al
000087C0  D023              shl byte [ebx],1
000087C2  FF                db 0xff
000087C3  FF                db 0xff
000087C4  3800              cmp [eax],al
000087C6  0000              add [eax],al
000087C8  0000              add [eax],al
000087CA  0000              add [eax],al
000087CC  8C00              mov [eax],es
000087CE  0000              add [eax],al
000087D0  48                dec eax
000087D1  0400              add al,0x0
000087D3  00FC              add ah,bh
000087D5  23FF              and edi,edi
000087D7  FF8C0100000041    dec dword [ecx+eax+0x41000000]
000087DE  0E                push cs
000087DF  088502410E0C      or [ebp+0xc0e4102],al
000087E5  8703              xchg eax,[ebx]
000087E7  41                inc ecx
000087E8  0E                push cs
000087E9  108604410E14      adc [esi+0x140e4104],al
000087EF  8305430E300257    add dword [dword 0x2300e43],byte +0x57
000087F6  0E                push cs
000087F7  38710E            cmp [ecx+0xe],dh
000087FA  3C45              cmp al,0x45
000087FC  0E                push cs
000087FD  40                inc eax
000087FE  48                dec eax
000087FF  0E                push cs
00008800  30680E            xor [eax+0xe],ch
00008803  3444              xor al,0x44
00008805  0E                push cs
00008806  38410E            cmp [ecx+0xe],al
00008809  3C47              cmp al,0x47
0000880B  0E                push cs
0000880C  40                inc eax
0000880D  4E                dec esi
0000880E  0E                push cs
0000880F  30790E            xor [ecx+0xe],bh
00008812  3441              xor al,0x41
00008814  0E                push cs
00008815  38410E            cmp [ecx+0xe],al
00008818  3C45              cmp al,0x45
0000881A  0E                push cs
0000881B  40                inc eax
0000881C  56                push esi
0000881D  0E                push cs
0000881E  1441              adc al,0x41
00008820  C3                ret
00008821  0E                push cs
00008822  1041C6            adc [ecx-0x3a],al
00008825  0E                push cs
00008826  0C41              or al,0x41
00008828  C7                db 0xc7
00008829  0E                push cs
0000882A  0841C5            or [ecx-0x3b],al
0000882D  0E                push cs
0000882E  0448              add al,0x48
00008830  0E                push cs
00008831  308305850286      xor [ebx-0x79fd7afb],al
00008837  0487              add al,0x87
00008839  03500E            add edx,[eax+0xe]
0000883C  38450E            cmp [ebp+0xe],al
0000883F  3C42              cmp al,0x42
00008841  0E                push cs
00008842  40                inc eax
00008843  48                dec eax
00008844  0E                push cs
00008845  30640E14          xor [esi+ecx+0x14],ah
00008849  41                inc ecx
0000884A  C3                ret
0000884B  0E                push cs
0000884C  1041C6            adc [ecx-0x3a],al
0000884F  0E                push cs
00008850  0C41              or al,0x41
00008852  C7                db 0xc7
00008853  0E                push cs
00008854  0841C5            or [ecx-0x3b],al
00008857  0E                push cs
00008858  0400              add al,0x0
0000885A  0000              add [eax],al
0000885C  1000              adc [eax],al
0000885E  0000              add [eax],al
00008860  D80400            fadd dword [eax+eax]
00008863  00FC              add ah,bh
00008865  24FF              and al,0xff
00008867  FF06              inc dword [esi]
00008869  0000              add [eax],al
0000886B  0000              add [eax],al
0000886D  0000              add [eax],al
0000886F  0010              add [eax],dl
00008871  0000              add [eax],al
00008873  00EC              add ah,ch
00008875  0400              add al,0x0
00008877  00F8              add al,bh
00008879  24FF              and al,0xff
0000887B  FF0A              dec dword [edx]
0000887D  0000              add [eax],al
0000887F  0000              add [eax],al
00008881  0000              add [eax],al
00008883  0010              add [eax],dl
00008885  0000              add [eax],al
00008887  0000              add [eax],al
00008889  050000F424        add eax,0x24f40000
0000888E  FF                db 0xff
0000888F  FF09              dec dword [ecx]
00008891  0000              add [eax],al
00008893  0000              add [eax],al
00008895  0000              add [eax],al
00008897  0010              add [eax],dl
00008899  0000              add [eax],al
0000889B  0014050000F024    add [eax+0x24f00000],dl
000088A2  FF                db 0xff
000088A3  FF03              inc dword [ebx]
000088A5  0000              add [eax],al
000088A7  0000              add [eax],al
000088A9  0000              add [eax],al
000088AB  0018              add [eax],bl
000088AD  0000              add [eax],al
000088AF  0028              add [eax],ch
000088B1  050000EC24        add eax,0x24ec0000
000088B6  FF                db 0xff
000088B7  FF22              jmp dword [edx]
000088B9  0000              add [eax],al
000088BB  0000              add [eax],al
000088BD  41                inc ecx
000088BE  0E                push cs
000088BF  08830260C30E      or [ebx+0xec36002],al
000088C5  0400              add al,0x0
000088C7  0018              add [eax],bl
000088C9  0000              add [eax],al
000088CB  00440500          add [ebp+eax+0x0],al
000088CF  0000              add [eax],al
000088D1  25FFFF2200        and eax,0x22ffff
000088D6  0000              add [eax],al
000088D8  00410E            add [ecx+0xe],al
000088DB  08830260C30E      or [ebx+0xec36002],al
000088E1  0400              add al,0x0
000088E3  0010              add [eax],dl
000088E5  0000              add [eax],al
000088E7  006005            add [eax+0x5],ah
000088EA  0000              add [eax],al
000088EC  1425              adc al,0x25
000088EE  FF                db 0xff
000088EF  FF6700            jmp dword [edi+0x0]
000088F2  0000              add [eax],al
000088F4  0000              add [eax],al
000088F6  0000              add [eax],al
000088F8  1000              adc [eax],al
000088FA  0000              add [eax],al
000088FC  7405              jz 0x8903
000088FE  0000              add [eax],al
00008900  7025              jo 0x8927
00008902  FF                db 0xff
00008903  FF0500000000      inc dword [dword 0x0]
00008909  0000              add [eax],al
0000890B  0010              add [eax],dl
0000890D  0000              add [eax],al
0000890F  00880500006C      add [eax+0x6c000005],cl
00008915  25FFFF1A00        and eax,0x1affff
0000891A  0000              add [eax],al
0000891C  0000              add [eax],al
0000891E  0000              add [eax],al
00008920  1000              adc [eax],al
00008922  0000              add [eax],al
00008924  9C                pushfd
00008925  0500007825        add eax,0x25780000
0000892A  FF                db 0xff
0000892B  FF1A              call dword far [edx]
0000892D  0000              add [eax],al
0000892F  0000              add [eax],al
00008931  0000              add [eax],al
00008933  0018              add [eax],bl
00008935  0000              add [eax],al
00008937  00B005000084      add [eax-0x7bfffffb],dh
0000893D  25FFFF0F00        and eax,0xfffff
00008942  0000              add [eax],al
00008944  00430E            add [ebx+0xe],al
00008947  1C42              sbb al,0x42
00008949  0E                push cs
0000894A  20490E            and [ecx+0xe],cl
0000894D  0400              add al,0x0
0000894F  0018              add [eax],bl
00008951  0000              add [eax],al
00008953  00CC              add ah,cl
00008955  0500007825        add eax,0x25780000
0000895A  FF                db 0xff
0000895B  FF0F              dec dword [edi]
0000895D  0000              add [eax],al
0000895F  0000              add [eax],al
00008961  43                inc ebx
00008962  0E                push cs
00008963  1C42              sbb al,0x42
00008965  0E                push cs
00008966  20490E            and [ecx+0xe],cl
00008969  0400              add al,0x0
0000896B  0018              add [eax],bl
0000896D  0000              add [eax],al
0000896F  00E8              add al,ch
00008971  0500006C25        add eax,0x256c0000
00008976  FF                db 0xff
00008977  FF0F              dec dword [edi]
00008979  0000              add [eax],al
0000897B  0000              add [eax],al
0000897D  43                inc ebx
0000897E  0E                push cs
0000897F  1C42              sbb al,0x42
00008981  0E                push cs
00008982  20490E            and [ecx+0xe],cl
00008985  0400              add al,0x0
00008987  0018              add [eax],bl
00008989  0000              add [eax],al
0000898B  000406            add [esi+eax],al
0000898E  0000              add [eax],al
00008990  60                pushad
00008991  25FFFF0F00        and eax,0xfffff
00008996  0000              add [eax],al
00008998  00430E            add [ebx+0xe],al
0000899B  1C42              sbb al,0x42
0000899D  0E                push cs
0000899E  20490E            and [ecx+0xe],cl
000089A1  0400              add al,0x0
000089A3  0018              add [eax],bl
000089A5  0000              add [eax],al
000089A7  0020              add [eax],ah
000089A9  06                push es
000089AA  0000              add [eax],al
000089AC  54                push esp
000089AD  25FFFF0F00        and eax,0xfffff
000089B2  0000              add [eax],al
000089B4  00430E            add [ebx+0xe],al
000089B7  1C42              sbb al,0x42
000089B9  0E                push cs
000089BA  20490E            and [ecx+0xe],cl
000089BD  0400              add al,0x0
000089BF  0018              add [eax],bl
000089C1  0000              add [eax],al
000089C3  003C06            add [esi+eax],bh
000089C6  0000              add [eax],al
000089C8  48                dec eax
000089C9  25FFFF0F00        and eax,0xfffff
000089CE  0000              add [eax],al
000089D0  00430E            add [ebx+0xe],al
000089D3  1C42              sbb al,0x42
000089D5  0E                push cs
000089D6  20490E            and [ecx+0xe],cl
000089D9  0400              add al,0x0
000089DB  0018              add [eax],bl
000089DD  0000              add [eax],al
000089DF  005806            add [eax+0x6],bl
000089E2  0000              add [eax],al
000089E4  3C25              cmp al,0x25
000089E6  FF                db 0xff
000089E7  FF0F              dec dword [edi]
000089E9  0000              add [eax],al
000089EB  0000              add [eax],al
000089ED  43                inc ebx
000089EE  0E                push cs
000089EF  1C42              sbb al,0x42
000089F1  0E                push cs
000089F2  20490E            and [ecx+0xe],cl
000089F5  0400              add al,0x0
000089F7  0018              add [eax],bl
000089F9  0000              add [eax],al
000089FB  00740600          add [esi+eax+0x0],dh
000089FF  0030              add [eax],dh
00008A01  25FFFF0F00        and eax,0xfffff
00008A06  0000              add [eax],al
00008A08  00430E            add [ebx+0xe],al
00008A0B  1C42              sbb al,0x42
00008A0D  0E                push cs
00008A0E  20490E            and [ecx+0xe],cl
00008A11  0400              add al,0x0
00008A13  0018              add [eax],bl
00008A15  0000              add [eax],al
00008A17  009006000024      add [eax+0x24000006],dl
00008A1D  25FFFF0F00        and eax,0xfffff
00008A22  0000              add [eax],al
00008A24  00430E            add [ebx+0xe],al
00008A27  1C42              sbb al,0x42
00008A29  0E                push cs
00008A2A  20490E            and [ecx+0xe],cl
00008A2D  0400              add al,0x0
00008A2F  0018              add [eax],bl
00008A31  0000              add [eax],al
00008A33  00AC0600001825    add [esi+eax+0x25180000],ch
00008A3A  FF                db 0xff
00008A3B  FF0F              dec dword [edi]
00008A3D  0000              add [eax],al
00008A3F  0000              add [eax],al
00008A41  43                inc ebx
00008A42  0E                push cs
00008A43  1C42              sbb al,0x42
00008A45  0E                push cs
00008A46  20490E            and [ecx+0xe],cl
00008A49  0400              add al,0x0
00008A4B  0018              add [eax],bl
00008A4D  0000              add [eax],al
00008A4F  00C8              add al,cl
00008A51  06                push es
00008A52  0000              add [eax],al
00008A54  0C25              or al,0x25
00008A56  FF                db 0xff
00008A57  FF0F              dec dword [edi]
00008A59  0000              add [eax],al
00008A5B  0000              add [eax],al
00008A5D  43                inc ebx
00008A5E  0E                push cs
00008A5F  1C42              sbb al,0x42
00008A61  0E                push cs
00008A62  20490E            and [ecx+0xe],cl
00008A65  0400              add al,0x0
00008A67  0018              add [eax],bl
00008A69  0000              add [eax],al
00008A6B  00E4              add ah,ah
00008A6D  06                push es
00008A6E  0000              add [eax],al
00008A70  0025FFFF0F00      add [dword 0xfffff],ah
00008A76  0000              add [eax],al
00008A78  00430E            add [ebx+0xe],al
00008A7B  1C42              sbb al,0x42
00008A7D  0E                push cs
00008A7E  20490E            and [ecx+0xe],cl
00008A81  0400              add al,0x0
00008A83  0018              add [eax],bl
00008A85  0000              add [eax],al
00008A87  0000              add [eax],al
00008A89  07                pop es
00008A8A  0000              add [eax],al
00008A8C  F4                hlt
00008A8D  24FF              and al,0xff
00008A8F  FF0F              dec dword [edi]
00008A91  0000              add [eax],al
00008A93  0000              add [eax],al
00008A95  43                inc ebx
00008A96  0E                push cs
00008A97  1C42              sbb al,0x42
00008A99  0E                push cs
00008A9A  20490E            and [ecx+0xe],cl
00008A9D  0400              add al,0x0
00008A9F  0018              add [eax],bl
00008AA1  0000              add [eax],al
00008AA3  001C07            add [edi+eax],bl
00008AA6  0000              add [eax],al
00008AA8  E824FFFF0F        call dword 0x100089d1
00008AAD  0000              add [eax],al
00008AAF  0000              add [eax],al
00008AB1  43                inc ebx
00008AB2  0E                push cs
00008AB3  1C42              sbb al,0x42
00008AB5  0E                push cs
00008AB6  20490E            and [ecx+0xe],cl
00008AB9  0400              add al,0x0
00008ABB  002C00            add [eax+eax],ch
00008ABE  0000              add [eax],al
00008AC0  3807              cmp [edi],al
00008AC2  0000              add [eax],al
00008AC4  DC24FF            fsub qword [edi+edi*8]
00008AC7  FFA900000000      jmp dword far [ecx+0x0]
00008ACD  41                inc ecx
00008ACE  0E                push cs
00008ACF  088302430E14      or [ebx+0x140e4302],al
00008AD5  46                inc esi
00008AD6  0E                push cs
00008AD7  18420E            sbb [edx+0xe],al
00008ADA  1C45              sbb al,0x45
00008ADC  0E                push cs
00008ADD  204D0E            and [ebp+0xe],cl
00008AE0  1002              adc [edx],al
00008AE2  850E              test [esi],ecx
00008AE4  0841C3            or [ecx-0x3d],al
00008AE7  0E                push cs
00008AE8  0400              add al,0x0
00008AEA  0000              add [eax],al
00008AEC  1000              adc [eax],al
00008AEE  0000              add [eax],al
00008AF0  680700005C        push dword 0x5c000007
00008AF5  25FFFF1C00        and eax,0x1cffff
00008AFA  0000              add [eax],al
00008AFC  0000              add [eax],al
00008AFE  0000              add [eax],al
00008B00  1000              adc [eax],al
00008B02  0000              add [eax],al
00008B04  7C07              jl 0x8b0d
00008B06  0000              add [eax],al
00008B08  6825FFFF1B        push dword 0x1bffff25
00008B0D  0000              add [eax],al
00008B0F  0000              add [eax],al
00008B11  0000              add [eax],al
00008B13  0010              add [eax],dl
00008B15  0000              add [eax],al
00008B17  009007000074      add [eax+0x74000007],dl
00008B1D  25FFFF1D00        and eax,0x1dffff
00008B22  0000              add [eax],al
00008B24  0000              add [eax],al
00008B26  0000              add [eax],al
00008B28  1800              sbb [eax],al
00008B2A  0000              add [eax],al
00008B2C  A4                movsb
00008B2D  07                pop es
00008B2E  0000              add [eax],al
00008B30  8025FFFF340000    and byte [dword 0x34ffff],0x0
00008B37  0000              add [eax],al
00008B39  41                inc ecx
00008B3A  0E                push cs
00008B3B  08830272C30E      or [ebx+0xec37202],al
00008B41  0400              add al,0x0
00008B43  0018              add [eax],bl
00008B45  0000              add [eax],al
00008B47  00C0              add al,al
00008B49  07                pop es
00008B4A  0000              add [eax],al
00008B4C  A4                movsb
00008B4D  25FFFF2D00        and eax,0x2dffff
00008B52  0000              add [eax],al
00008B54  00410E            add [ecx+0xe],al
00008B57  0883026BC30E      or [ebx+0xec36b02],al
00008B5D  0400              add al,0x0
00008B5F  003400            add [eax+eax],dh
00008B62  0000              add [eax],al
00008B64  DC07              fadd qword [edi]
00008B66  0000              add [eax],al
00008B68  B825FFFF99        mov eax,0x99ffff25
00008B6D  0000              add [eax],al
00008B6F  0000              add [eax],al
00008B71  41                inc ecx
00008B72  0E                push cs
00008B73  088702410E0C      or [edi+0xc0e4102],al
00008B79  8603              xchg al,[ebx]
00008B7B  41                inc ecx
00008B7C  0E                push cs
00008B7D  1083046A0E1C      adc [ebx+0x1c0e6a04],al
00008B83  41                inc ecx
00008B84  0E                push cs
00008B85  20480E            and [eax+0xe],cl
00008B88  10450A            adc [ebp+0xa],al
00008B8B  C3                ret
00008B8C  0E                push cs
00008B8D  0C43              or al,0x43
00008B8F  C6                db 0xc6
00008B90  0E                push cs
00008B91  0841C7            or [ecx-0x39],al
00008B94  0E                push cs
00008B95  0441              add al,0x41
00008B97  0B3400            or esi,[eax+eax]
00008B9A  0000              add [eax],al
00008B9C  1408              adc al,0x8
00008B9E  0000              add [eax],al
00008BA0  2026              and [esi],ah
00008BA2  FF                db 0xff
00008BA3  FF8900000000      dec dword [ecx+0x0]
00008BA9  41                inc ecx
00008BAA  0E                push cs
00008BAB  088602410E0C      or [esi+0xc0e4102],al
00008BB1  830343            add dword [ebx],byte +0x43
00008BB4  0E                push cs
00008BB5  10680E            adc [eax+0xe],ch
00008BB8  1C41              sbb al,0x41
00008BBA  0E                push cs
00008BBB  20480E            and [eax+0xe],cl
00008BBE  10470A            adc [edi+0xa],al
00008BC1  0E                push cs
00008BC2  0C43              or al,0x43
00008BC4  C3                ret
00008BC5  0E                push cs
00008BC6  0841C6            or [ecx-0x3a],al
00008BC9  0E                push cs
00008BCA  044F              add al,0x4f
00008BCC  0B00              or eax,[eax]
00008BCE  0000              add [eax],al
00008BD0  3C00              cmp al,0x0
00008BD2  0000              add [eax],al
00008BD4  4C                dec esp
00008BD5  0800              or [eax],al
00008BD7  007826            add [eax+0x26],bh
00008BDA  FF                db 0xff
00008BDB  FFB700000000      push dword [edi+0x0]
00008BE1  41                inc ecx
00008BE2  0E                push cs
00008BE3  088302430E10      or [ebx+0x100e4302],al
00008BE9  4B                dec ebx
00008BEA  0E                push cs
00008BEB  1C4E              sbb al,0x4e
00008BED  0E                push cs
00008BEE  20540E10          and [esi+ecx+0x10],dl
00008BF2  5C                pop esp
00008BF3  0E                push cs
00008BF4  1C41              sbb al,0x41
00008BF6  0E                push cs
00008BF7  20480E            and [eax+0xe],cl
00008BFA  10470A            adc [edi+0xa],al
00008BFD  0E                push cs
00008BFE  0846C3            or [esi-0x3d],al
00008C01  0E                push cs
00008C02  044D              add al,0x4d
00008C04  0B6F0E            or ebp,[edi+0xe]
00008C07  1C42              sbb al,0x42
00008C09  0E                push cs
00008C0A  20540E10          and [esi+ecx+0x10],dl
00008C0E  0000              add [eax],al
00008C10  1000              adc [eax],al
00008C12  0000              add [eax],al
00008C14  8C08              mov [eax],cs
00008C16  0000              add [eax],al
00008C18  F8                clc
00008C19  26                es
00008C1A  FF                db 0xff
00008C1B  FF0D00000000      dec dword [dword 0x0]
00008C21  0000              add [eax],al
00008C23  0010              add [eax],dl
00008C25  0000              add [eax],al
00008C27  00A0080000F4      add [eax-0xbfffff8],ah
00008C2D  26                es
00008C2E  FF                db 0xff
00008C2F  FF0D00000000      dec dword [dword 0x0]
00008C35  0000              add [eax],al
00008C37  0010              add [eax],dl
00008C39  0000              add [eax],al
00008C3B  00B4080000F026    add [eax+ecx+0x26f00000],dh
00008C42  FF                db 0xff
00008C43  FF17              call dword [edi]
00008C45  0000              add [eax],al
00008C47  0000              add [eax],al
00008C49  0000              add [eax],al
00008C4B  0010              add [eax],dl
00008C4D  0000              add [eax],al
00008C4F  00C8              add al,cl
00008C51  0800              or [eax],al
00008C53  00FC              add ah,bh
00008C55  26                es
00008C56  FF                db 0xff
00008C57  FF17              call dword [edi]
00008C59  0000              add [eax],al
00008C5B  0000              add [eax],al
00008C5D  0000              add [eax],al
00008C5F  0010              add [eax],dl
00008C61  0000              add [eax],al
00008C63  00DC              add ah,bl
00008C65  0800              or [eax],al
00008C67  0008              add [eax],cl
00008C69  27                daa
00008C6A  FF                db 0xff
00008C6B  FF16              call dword [esi]
00008C6D  0000              add [eax],al
00008C6F  0000              add [eax],al
00008C71  0000              add [eax],al
00008C73  0010              add [eax],dl
00008C75  0000              add [eax],al
00008C77  00F0              add al,dh
00008C79  0800              or [eax],al
00008C7B  001427            add [edi],dl
00008C7E  FF                db 0xff
00008C7F  FF                db 0xff
00008C80  F9                stc
00008C81  0000              add [eax],al
00008C83  0000              add [eax],al
00008C85  0000              add [eax],al
00008C87  0030              add [eax],dh
00008C89  0000              add [eax],al
00008C8B  000409            add [ecx+ecx],al
00008C8E  0000              add [eax],al
00008C90  0028              add [eax],ch
00008C92  FF                db 0xff
00008C93  FF4200            inc dword [edx+0x0]
00008C96  0000              add [eax],al
00008C98  00410E            add [ecx+0xe],al
00008C9B  088302430E10      or [ebx+0x100e4302],al
00008CA1  48                dec eax
00008CA2  0E                push cs
00008CA3  1C45              sbb al,0x45
00008CA5  0E                push cs
00008CA6  20480E            and [eax+0xe],cl
00008CA9  1446              adc al,0x46
00008CAB  0E                push cs
00008CAC  18440E1C          sbb [esi+ecx+0x1c],al
00008CB0  45                inc ebp
00008CB1  0E                push cs
00008CB2  20560E            and [esi+0xe],dl
00008CB5  0843C3            or [ebx-0x3d],al
00008CB8  0E                push cs
00008CB9  0400              add al,0x0
00008CBB  00940000003809    add [eax+eax+0x9380000],dl
00008CC2  0000              add [eax],al
00008CC4  1C28              sbb al,0x28
00008CC6  FF                db 0xff
00008CC7  FF2E              jmp dword far [esi]
00008CC9  0200              add al,[eax]
00008CCB  0000              add [eax],al
00008CCD  41                inc ecx
00008CCE  0E                push cs
00008CCF  088502410E0C      or [ebp+0xc0e4102],al
00008CD5  8703              xchg eax,[ebx]
00008CD7  41                inc ecx
00008CD8  0E                push cs
00008CD9  108604410E14      adc [esi+0x140e4104],al
00008CDF  8305430E4C450E    add dword [dword 0x454c0e43],byte +0xe
00008CE6  50                push eax
00008CE7  50                push eax
00008CE8  0E                push cs
00008CE9  40                inc eax
00008CEA  02590E            add bl,[ecx+0xe]
00008CED  4C                dec esp
00008CEE  45                inc ebp
00008CEF  0E                push cs
00008CF0  50                push eax
00008CF1  4D                dec ebp
00008CF2  0E                push cs
00008CF3  40                inc eax
00008CF4  52                push edx
00008CF5  0A0E              or cl,[esi]
00008CF7  1443              adc al,0x43
00008CF9  C3                ret
00008CFA  0E                push cs
00008CFB  1041C6            adc [ecx-0x3a],al
00008CFE  0E                push cs
00008CFF  0C41              or al,0x41
00008D01  C7                db 0xc7
00008D02  0E                push cs
00008D03  0841C5            or [ecx-0x3b],al
00008D06  0E                push cs
00008D07  0441              add al,0x41
00008D09  0B430E            or eax,[ebx+0xe]
00008D0C  4C                dec esp
00008D0D  45                inc ebp
00008D0E  0E                push cs
00008D0F  50                push eax
00008D10  02680E            add ch,[eax+0xe]
00008D13  40                inc eax
00008D14  55                push ebp
00008D15  0E                push cs
00008D16  4C                dec esp
00008D17  45                inc ebp
00008D18  0E                push cs
00008D19  50                push eax
00008D1A  48                dec eax
00008D1B  0E                push cs
00008D1C  40                inc eax
00008D1D  51                push ecx
00008D1E  0E                push cs
00008D1F  4C                dec esp
00008D20  45                inc ebp
00008D21  0E                push cs
00008D22  50                push eax
00008D23  48                dec eax
00008D24  0E                push cs
00008D25  40                inc eax
00008D26  55                push ebp
00008D27  0E                push cs
00008D28  4C                dec esp
00008D29  45                inc ebp
00008D2A  0E                push cs
00008D2B  50                push eax
00008D2C  48                dec eax
00008D2D  0E                push cs
00008D2E  40                inc eax
00008D2F  51                push ecx
00008D30  0E                push cs
00008D31  4C                dec esp
00008D32  45                inc ebp
00008D33  0E                push cs
00008D34  50                push eax
00008D35  48                dec eax
00008D36  0E                push cs
00008D37  40                inc eax
00008D38  58                pop eax
00008D39  0E                push cs
00008D3A  4C                dec esp
00008D3B  45                inc ebp
00008D3C  0E                push cs
00008D3D  50                push eax
00008D3E  4C                dec esp
00008D3F  0E                push cs
00008D40  40                inc eax
00008D41  5D                pop ebp
00008D42  0E                push cs
00008D43  4C                dec esp
00008D44  44                inc esp
00008D45  0E                push cs
00008D46  50                push eax
00008D47  48                dec eax
00008D48  0E                push cs
00008D49  40                inc eax
00008D4A  61                popad
00008D4B  0E                push cs
00008D4C  4C                dec esp
00008D4D  44                inc esp
00008D4E  0E                push cs
00008D4F  50                push eax
00008D50  48                dec eax
00008D51  0E                push cs
00008D52  40                inc eax
00008D53  0010              add [eax],dl
00008D55  0000              add [eax],al
00008D57  00D0              add al,dl
00008D59  0900              or [eax],eax
00008D5B  00B429FFFF0D00    add [ecx+ebp+0xdffff],dh
00008D62  0000              add [eax],al
00008D64  0000              add [eax],al
00008D66  0000              add [eax],al
00008D68  1000              adc [eax],al
00008D6A  0000              add [eax],al
00008D6C  E409              in al,0x9
00008D6E  0000              add [eax],al
00008D70  B029              mov al,0x29
00008D72  FF                db 0xff
00008D73  FF10              call dword [eax]
00008D75  0000              add [eax],al
00008D77  0000              add [eax],al
00008D79  0000              add [eax],al
00008D7B  0010              add [eax],dl
00008D7D  0000              add [eax],al
00008D7F  00F8              add al,bh
00008D81  0900              or [eax],eax
00008D83  00AC29FFFF5900    add [ecx+ebp+0x59ffff],ch
00008D8A  0000              add [eax],al
00008D8C  0000              add [eax],al
00008D8E  0000              add [eax],al
00008D90  1C00              sbb al,0x0
00008D92  0000              add [eax],al
00008D94  0C0A              or al,0xa
00008D96  0000              add [eax],al
00008D98  F8                clc
00008D99  29FF              sub edi,edi
00008D9B  FF2D00000000      jmp dword far [dword 0x0]
00008DA1  43                inc ebx
00008DA2  0E                push cs
00008DA3  1445              adc al,0x45
00008DA5  0E                push cs
00008DA6  18420E            sbb [edx+0xe],al
00008DA9  1C46              sbb al,0x46
00008DAB  0E                push cs
00008DAC  205C0E04          and [esi+ecx+0x4],bl
00008DB0  1000              adc [eax],al
00008DB2  0000              add [eax],al
00008DB4  2C0A              sub al,0xa
00008DB6  0000              add [eax],al
00008DB8  082A              or [edx],ch
00008DBA  FF                db 0xff
00008DBB  FF0A              dec dword [edx]
00008DBD  0000              add [eax],al
00008DBF  0000              add [eax],al
00008DC1  0000              add [eax],al
00008DC3  0010              add [eax],dl
00008DC5  0000              add [eax],al
00008DC7  00400A            add [eax+0xa],al
00008DCA  0000              add [eax],al
00008DCC  042A              add al,0x2a
00008DCE  FF                db 0xff
00008DCF  FF28              jmp dword far [eax]
00008DD1  0000              add [eax],al
00008DD3  0000              add [eax],al
00008DD5  0000              add [eax],al
00008DD7  004000            add [eax+0x0],al
00008DDA  0000              add [eax],al
00008DDC  54                push esp
00008DDD  0A00              or al,[eax]
00008DDF  0020              add [eax],ah
00008DE1  2AFF              sub bh,bh
00008DE3  FF5E00            call dword far [esi+0x0]
00008DE6  0000              add [eax],al
00008DE8  00410E            add [ecx+0xe],al
00008DEB  088602410E0C      or [esi+0xc0e4102],al
00008DF1  830343            add dword [ebx],byte +0x43
00008DF4  0E                push cs
00008DF5  10590E            adc [ecx+0xe],bl
00008DF8  1445              adc al,0x45
00008DFA  0E                push cs
00008DFB  18460E            sbb [esi+0xe],al
00008DFE  1C41              sbb al,0x41
00008E00  0E                push cs
00008E01  20480E            and [eax+0xe],cl
00008E04  10540E14          adc [esi+ecx+0x14],dl
00008E08  45                inc ebp
00008E09  0E                push cs
00008E0A  18420E            sbb [edx+0xe],al
00008E0D  1C46              sbb al,0x46
00008E0F  0E                push cs
00008E10  20480E            and [eax+0xe],cl
00008E13  0C41              or al,0x41
00008E15  C3                ret
00008E16  0E                push cs
00008E17  0841C6            or [ecx-0x3a],al
00008E1A  0E                push cs
00008E1B  043C              add al,0x3c
00008E1D  0000              add [eax],al
00008E1F  00980A00003C      add [eax+0x3c00000a],bl
00008E25  2AFF              sub bh,bh
00008E27  FF5801            call dword far [eax+0x1]
00008E2A  0000              add [eax],al
00008E2C  00410E            add [ecx+0xe],al
00008E2F  088702410E0C      or [edi+0xc0e4102],al
00008E35  8603              xchg al,[ebx]
00008E37  41                inc ecx
00008E38  0E                push cs
00008E39  108304430E20      adc [ebx+0x200e4304],al
00008E3F  02650A            add ah,[ebp+0xa]
00008E42  0E                push cs
00008E43  1041C3            adc [ecx-0x3d],al
00008E46  0E                push cs
00008E47  0C41              or al,0x41
00008E49  C6                db 0xc6
00008E4A  0E                push cs
00008E4B  0841C7            or [ecx-0x39],al
00008E4E  0E                push cs
00008E4F  0442              add al,0x42
00008E51  0B02              or eax,[edx]
00008E53  C7                db 0xc7
00008E54  0E                push cs
00008E55  2C42              sub al,0x42
00008E57  0E                push cs
00008E58  305A0E            xor [edx+0xe],bl
00008E5B  203400            and [eax+eax],dh
00008E5E  0000              add [eax],al
00008E60  D80A              fmul dword [edx]
00008E62  0000              add [eax],al
00008E64  5C                pop esp
00008E65  2BFF              sub edi,edi
00008E67  FF                db 0xff
00008E68  3C00              cmp al,0x0
00008E6A  0000              add [eax],al
00008E6C  00410E            add [ecx+0xe],al
00008E6F  088602410E0C      or [esi+0xc0e4102],al
00008E75  830343            add dword [ebx],byte +0x43
00008E78  0E                push cs
00008E79  1C45              sbb al,0x45
00008E7B  0E                push cs
00008E7C  20480E            and [eax+0xe],cl
00008E7F  10540E1C          adc [esi+ecx+0x1c],dl
00008E83  44                inc esp
00008E84  0E                push cs
00008E85  20480E            and [eax+0xe],cl
00008E88  10470E            adc [edi+0xe],al
00008E8B  0C41              or al,0x41
00008E8D  C3                ret
00008E8E  0E                push cs
00008E8F  0841C6            or [ecx-0x3a],al
00008E92  0E                push cs
00008E93  0410              add al,0x10
00008E95  0000              add [eax],al
00008E97  0010              add [eax],dl
00008E99  0B00              or eax,[eax]
00008E9B  00642BFF          add [ebx+ebp-0x1],ah
00008E9F  FF03              inc dword [ebx]
00008EA1  0000              add [eax],al
00008EA3  0000              add [eax],al
00008EA5  0000              add [eax],al
00008EA7  003C00            add [eax+eax],bh
00008EAA  0000              add [eax],al
00008EAC  240B              and al,0xb
00008EAE  0000              add [eax],al
00008EB0  60                pushad
00008EB1  2BFF              sub edi,edi
00008EB3  FF5A01            call dword far [edx+0x1]
00008EB6  0000              add [eax],al
00008EB8  00410E            add [ecx+0xe],al
00008EBB  088502410E0C      or [ebp+0xc0e4102],al
00008EC1  8703              xchg eax,[ebx]
00008EC3  41                inc ecx
00008EC4  0E                push cs
00008EC5  108604410E14      adc [esi+0x140e4104],al
00008ECB  8305430E18034E    add dword [dword 0x3180e43],byte +0x4e
00008ED2  010E              add [esi],ecx
00008ED4  1441              adc al,0x41
00008ED6  C3                ret
00008ED7  0E                push cs
00008ED8  1041C6            adc [ecx-0x3a],al
00008EDB  0E                push cs
00008EDC  0C41              or al,0x41
00008EDE  C7                db 0xc7
00008EDF  0E                push cs
00008EE0  0841C5            or [ecx-0x3b],al
00008EE3  0E                push cs
00008EE4  0400              add al,0x0
00008EE6  0000              add [eax],al
00008EE8  1800              sbb [eax],al
00008EEA  0000              add [eax],al
00008EEC  640B00            or eax,[fs:eax]
00008EEF  00802CFFFF49      add [eax+0x49ffff2c],al
00008EF5  0000              add [eax],al
00008EF7  0000              add [eax],al
00008EF9  43                inc ebx
00008EFA  0E                push cs
00008EFB  10710A            adc [ecx+0xa],dh
00008EFE  0E                push cs
00008EFF  044C              add al,0x4c
00008F01  0B00              or eax,[eax]
00008F03  0010              add [eax],dl
00008F05  0000              add [eax],al
00008F07  00800B0000B4      add [eax-0x4bfffff5],al
00008F0D  2CFF              sub al,0xff
00008F0F  FF0F              dec dword [edi]
00008F11  0000              add [eax],al
00008F13  0000              add [eax],al
00008F15  0000              add [eax],al
00008F17  002400            add [eax+eax],ah
00008F1A  0000              add [eax],al
00008F1C  94                xchg eax,esp
00008F1D  0B00              or eax,[eax]
00008F1F  00B02CFFFF3A      add [eax+0x3affff2c],dh
00008F25  0000              add [eax],al
00008F27  0000              add [eax],al
00008F29  41                inc ecx
00008F2A  0E                push cs
00008F2B  088302430E1C      or [ebx+0x1c0e4302],al
00008F31  45                inc ebp
00008F32  0E                push cs
00008F33  20480E            and [eax+0xe],cl
00008F36  10650E            adc [ebp+0xe],ah
00008F39  0843C3            or [ebx-0x3d],al
00008F3C  0E                push cs
00008F3D  0400              add al,0x0
00008F3F  00440000          add [eax+eax+0x0],al
00008F43  00BC0B0000C82C    add [ebx+ecx+0x2cc80000],bh
00008F4A  FF                db 0xff
00008F4B  FF                db 0xff
00008F4C  7A00              jpe 0x8f4e
00008F4E  0000              add [eax],al
00008F50  00410E            add [ecx+0xe],al
00008F53  088302430E10      or [ebx+0x100e4302],al
00008F59  53                push ebx
00008F5A  0E                push cs
00008F5B  1C4B              sbb al,0x4b
00008F5D  0E                push cs
00008F5E  20480E            and [eax+0xe],cl
00008F61  105F0A            adc [edi+0xa],bl
00008F64  0E                push cs
00008F65  0841C3            or [ecx-0x3d],al
00008F68  0E                push cs
00008F69  0446              add al,0x46
00008F6B  0B430E            or eax,[ebx+0xe]
00008F6E  1C41              sbb al,0x41
00008F70  0E                push cs
00008F71  20480E            and [eax+0xe],cl
00008F74  10430A            adc [ebx+0xa],al
00008F77  0E                push cs
00008F78  0841C3            or [ecx-0x3d],al
00008F7B  0E                push cs
00008F7C  0450              add al,0x50
00008F7E  0B430E            or eax,[ebx+0xe]
00008F81  0846C3            or [esi-0x3d],al
00008F84  0E                push cs
00008F85  0400              add al,0x0
00008F87  0030              add [eax],dh
00008F89  0000              add [eax],al
00008F8B  00040C            add [esp+ecx],al
00008F8E  0000              add [eax],al
00008F90  002DFFFF6300      add [dword 0x63ffff],ch
00008F96  0000              add [eax],al
00008F98  00410E            add [ecx+0xe],al
00008F9B  088302430E10      or [ebx+0x100e4302],al
00008FA1  5F                pop edi
00008FA2  0E                push cs
00008FA3  1C4B              sbb al,0x4b
00008FA5  0E                push cs
00008FA6  20480E            and [eax+0xe],cl
00008FA9  105F0E            adc [edi+0xe],bl
00008FAC  1C41              sbb al,0x41
00008FAE  0E                push cs
00008FAF  20480E            and [eax+0xe],cl
00008FB2  10430E            adc [ebx+0xe],al
00008FB5  0841C3            or [ecx-0x3d],al
00008FB8  0E                push cs
00008FB9  0400              add al,0x0
00008FBB  002C00            add [eax+eax],ch
00008FBE  0000              add [eax],al
00008FC0  380C00            cmp [eax+eax],cl
00008FC3  003C2DFFFF0F01    add [ebp+0x10fffff],bh
00008FCA  0000              add [eax],al
00008FCC  0002              add [edx],al
00008FCE  A80E              test al,0xe
00008FD0  1453              adc al,0x53
00008FD2  0E                push cs
00008FD3  18420E            sbb [edx+0xe],al
00008FD6  1C45              sbb al,0x45
00008FD8  0E                push cs
00008FD9  20540E1C          and [esi+ecx+0x1c],dl
00008FDD  41                inc ecx
00008FDE  0E                push cs
00008FDF  18450E            sbb [ebp+0xe],al
00008FE2  1C42              sbb al,0x42
00008FE4  0E                push cs
00008FE5  20700E            and [eax+0xe],dh
00008FE8  0400              add al,0x0
00008FEA  0000              add [eax],al
00008FEC  2020              and [eax],ah
00008FEE  54                push esp
00008FEF  49                dec ecx
00008FF0  4D                dec ebp
00008FF1  45                inc ebp
00008FF2  52                push edx
00008FF3  3A20              cmp ah,[eax]
00008FF5  25642C206B        and eax,0x6b202c64
00008FFA  5F                pop edi
00008FFB  746F              jz 0x906c
00008FFD  7461              jz 0x9060
00008FFF  6C                insb
00009000  7461              jz 0x9063
00009002  736B              jnc 0x906f
00009004  733A              jnc 0x9040
00009006  202564206B5F      and [dword 0x5f6b2064],ah
0000900C  6465627567        bound esi,[gs:ebp+0x67]
00009011  2025780A0000      and [dword 0xa78],ah
00009017  004865            add [eax+0x65],cl
0000901A  6C                insb
0000901B  6C                insb
0000901C  6F                outsd
0000901D  2C20              sub al,0x20
0000901F  6B65726E          imul esp,[ebp+0x72],byte +0x6e
00009023  656C              gs insb
00009025  20576F            and [edi+0x6f],dl
00009028  726C              jc 0x9096
0000902A  64210A            and [fs:edx],ecx
0000902D  4C                dec esp
0000902E  696E65310A4C69    imul ebp,[esi+0x65],dword 0x694c0a31
00009035  6E                outsb
00009036  65320A            xor cl,[gs:edx]
00009039  094C696E          or [ecx+ebp*2+0x6e],ecx
0000903D  65330A            xor ecx,[gs:edx]
00009040  0000              add [eax],al
00009042  0000              add [eax],al
00009044  6C                insb
00009045  696D6974313A20    imul ebp,[ebp+0x69],dword 0x203a3174
0000904C  25642C2062        and eax,0x62202c64
00009051  61                popad
00009052  7365              jnc 0x90b9
00009054  313A              xor [edx],edi
00009056  2025642C2062      and [dword 0x62202c64],ah
0000905C  61                popad
0000905D  7365              jnc 0x90c4
0000905F  323A              xor bh,[edx]
00009061  2025642C2074      and [dword 0x74202c64],ah
00009067  7970              jns 0x90d9
00009069  653A20            cmp ah,[gs:eax]
0000906C  25642C2073        and eax,0x73202c64
00009071  3A20              cmp ah,[eax]
00009073  25642C2064        and eax,0x64202c64
00009078  706C              jo 0x90e6
0000907A  3A20              cmp ah,[eax]
0000907C  25642C2070        and eax,0x70202c64
00009081  3A20              cmp ah,[eax]
00009083  25642C200A        and eax,0xa202c64
00009088  2020              and [eax],ah
0000908A  2020              and [eax],ah
0000908C  2020              and [eax],ah
0000908E  2020              and [eax],ah
00009090  2020              and [eax],ah
00009092  6C                insb
00009093  696D6974323A20    imul ebp,[ebp+0x69],dword 0x203a3274
0000909A  25642C2061        and eax,0x61202c64
0000909F  766C              jna 0x910d
000090A1  3A20              cmp ah,[eax]
000090A3  25642C206C        and eax,0x6c202c64
000090A8  3A20              cmp ah,[eax]
000090AA  25642C2064        and eax,0x64202c64
000090AF  623A              bound edi,[edx]
000090B1  2025642C2067      and [dword 0x67202c64],ah
000090B7  3A20              cmp ah,[eax]
000090B9  25642C2062        and eax,0x62202c64
000090BE  61                popad
000090BF  7365              jnc 0x9126
000090C1  333A              xor edi,[edx]
000090C3  2025640A0A00      and [dword 0xa0a64],ah
000090C9  0000              add [eax],al
000090CB  006C696D          add [ecx+ebp*2+0x6d],ch
000090CF  69743A2025782C20  imul esi,[edx+edi+0x20],dword 0x202c7825
000090D7  626173            bound esp,[ecx+0x73]
000090DA  653A20            cmp ah,[gs:eax]
000090DD  25782C2074        and eax,0x74202c78
000090E2  7970              jns 0x9154
000090E4  653A20            cmp ah,[gs:eax]
000090E7  25780A0000        and eax,0xa78
000090EC  6964743A0A096F66  imul esp,[esp+esi*2+0x3a],dword 0x666f090a
000090F4  667365            o16 jnc 0x915c
000090F7  7431              jz 0x912a
000090F9  3A20              cmp ah,[eax]
000090FB  25640A0973        and eax,0x73090a64
00009100  656C              gs insb
00009102  6563746F72        arpl [gs:edi+ebp*2+0x72],si
00009107  3A20              cmp ah,[eax]
00009109  25640A0975        and eax,0x75090a64
0000910E  6E                outsb
0000910F  7573              jnz 0x9184
00009111  65645F            fs pop edi
00009114  6D                insd
00009115  7573              jnz 0x918a
00009117  745F              jz 0x9178
00009119  62655F            bound esp,[ebp+0x5f]
0000911C  7A65              jpe 0x9183
0000911E  726F              jc 0x918f
00009120  3A20              cmp ah,[eax]
00009122  25640A0967        and eax,0x67090a64
00009127  61                popad
00009128  7465              jz 0x918f
0000912A  5F                pop edi
0000912B  7479              jz 0x91a6
0000912D  7065              jo 0x9194
0000912F  3A20              cmp ah,[eax]
00009131  25640A0973        and eax,0x73090a64
00009136  686F756C64        push dword 0x646c756f
0000913B  5F                pop edi
0000913C  62655F            bound esp,[ebp+0x5f]
0000913F  7365              jnc 0x91a6
00009141  743A              jz 0x917d
00009143  2025640A0969      and [dword 0x69090a64],ah
00009149  7333              jnc 0x917e
0000914B  323A              xor bh,[edx]
0000914D  2025640A0973      and [dword 0x73090a64],ah
00009153  686F756C64        push dword 0x646c756f
00009158  5F                pop edi
00009159  62655F            bound esp,[ebp+0x5f]
0000915C  756E              jnz 0x91cc
0000915E  7365              jnc 0x91c5
00009160  743A              jz 0x919c
00009162  2025640A0964      and [dword 0x64090a64],ah
00009168  706C              jo 0x91d6
0000916A  3A20              cmp ah,[eax]
0000916C  25640A0970        and eax,0x70090a64
00009171  3A20              cmp ah,[eax]
00009173  25640A096F        and eax,0x6f090a64
00009178  66667365          o16 jnc 0x91e1
0000917C  7432              jz 0x91b0
0000917E  3A20              cmp ah,[eax]
00009180  25640A000A        and eax,0xa000a64
00009185  696E697469616C    imul ebp,[esi+0x69],dword 0x6c616974
0000918C  697A696E672069    imul edi,[edx+0x69],dword 0x6920676e
00009193  6E                outsb
00009194  7465              jz 0x91fb
00009196  7272              jc 0x920a
00009198  7570              jnz 0x920a
0000919A  7473              jz 0x920f
0000919C  2E202E            and [cs:esi],ch
0000919F  202E              and [esi],ch
000091A1  0A0A              or cl,[edx]
000091A3  007374            add [ebx+0x74],dh
000091A6  61                popad
000091A7  636B3A            arpl [ebx+0x3a],bp
000091AA  2025782C2065      and [dword 0x65202c78],ah
000091B0  6E                outsb
000091B1  7472              jz 0x9225
000091B3  793A              jns 0x91ef
000091B5  2025782C2073      and [dword 0x73202c78],ah
000091BB  7461              jz 0x921e
000091BD  636B20            arpl [ebx+0x20],bp
000091C0  6D                insd
000091C1  696E757320656E    imul ebp,[esi+0x75],dword 0x6e652073
000091C8  7472              jz 0x923c
000091CA  793A              jns 0x9206
000091CC  2025780A0000      and [dword 0xa78],ah
000091D2  0000              add [eax],al
000091D4  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091D9  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091DE  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091E3  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091E8  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091ED  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091F2  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091F7  3D3D3D3D3D        cmp eax,0x3d3d3d3d
000091FC  3D3D3D3D3D        cmp eax,0x3d3d3d3d
00009201  3D3D3D3D3D        cmp eax,0x3d3d3d3d
00009206  3D3D3D3D3D        cmp eax,0x3d3d3d3d
0000920B  3D3D3D3D0A        cmp eax,0xa3d3d3d
00009210  0000              add [eax],al
00009212  0000              add [eax],al
00009214  47                inc edi
00009215  43                inc ebx
00009216  43                inc ebx
00009217  3A20              cmp ah,[eax]
00009219  28474E            sub [edi+0x4e],al
0000921C  55                push ebp
0000921D  2920              sub [eax],esp
0000921F  342E              xor al,0x2e
00009221  392E              cmp [esi],ebp
00009223  3300              xor eax,[eax]
00009225  002E              add [esi],ch
00009227  7379              jnc 0x92a2
00009229  6D                insd
0000922A  7461              jz 0x928d
0000922C  6200              bound eax,[eax]
0000922E  2E7374            cs jnc 0x92a5
00009231  7274              jc 0x92a7
00009233  61                popad
00009234  6200              bound eax,[eax]
00009236  2E7368            cs jnc 0x92a1
00009239  7374              jnc 0x92af
0000923B  7274              jc 0x92b1
0000923D  61                popad
0000923E  6200              bound eax,[eax]
00009240  2E7465            cs jz 0x92a8
00009243  7874              js 0x92b9
00009245  002E              add [esi],ch
00009247  627373            bound esi,[ebx+0x73]
0000924A  002E              add [esi],ch
0000924C  6764742C          fs jz 0x927c
00009250  002E              add [esi],ch
00009252  626F6F            bound ebp,[edi+0x6f]
00009255  7473              jz 0x92ca
00009257  7472              jz 0x92cb
00009259  61                popad
0000925A  705F              jo 0x92bb
0000925C  7374              jnc 0x92d2
0000925E  61                popad
0000925F  636B2C            arpl [ebx+0x2c],bp
00009262  002E              add [esi],ch
00009264  6972712E746162    imul esi,[edx+0x71],dword 0x6261742e
0000926B  6C                insb
0000926C  652C00            gs sub al,0x0
0000926F  2E6461            fs popad
00009272  7461              jz 0x92d5
00009274  002E              add [esi],ch
00009276  726F              jc 0x92e7
00009278  6461              fs popad
0000927A  7461              jz 0x92dd
0000927C  002E              add [esi],ch
0000927E  726F              jc 0x92ef
00009280  6461              fs popad
00009282  7461              jz 0x92e5
00009284  2E7374            cs jnc 0x92fb
00009287  7231              jc 0x92ba
00009289  2E3100            xor [cs:eax],eax
0000928C  2E65685F667261    gs push dword 0x6172665f
00009293  6D                insd
00009294  65002E            add [gs:esi],ch
00009297  726F              jc 0x9308
00009299  6461              fs popad
0000929B  7461              jz 0x92fe
0000929D  2E7374            cs jnc 0x9314
000092A0  7231              jc 0x92d3
000092A2  2E3400            cs xor al,0x0
000092A5  2E636F6D          arpl [cs:edi+0x6d],bp
000092A9  6D                insd
000092AA  656E              gs outsb
000092AC  7400              jz 0x92ae
000092AE  0000              add [eax],al
000092B0  0000              add [eax],al
000092B2  0000              add [eax],al
000092B4  0000              add [eax],al
000092B6  0000              add [eax],al
000092B8  0000              add [eax],al
000092BA  0000              add [eax],al
000092BC  0000              add [eax],al
000092BE  0000              add [eax],al
000092C0  0000              add [eax],al
000092C2  0000              add [eax],al
000092C4  0000              add [eax],al
000092C6  1000              adc [eax],al
000092C8  0000              add [eax],al
000092CA  0000              add [eax],al
000092CC  0300              add eax,[eax]
000092CE  0100              add [eax],eax
000092D0  0000              add [eax],al
000092D2  0000              add [eax],al
000092D4  0020              add [eax],ah
000092D6  1000              adc [eax],al
000092D8  0000              add [eax],al
000092DA  0000              add [eax],al
000092DC  0300              add eax,[eax]
000092DE  0200              add al,[eax]
000092E0  0000              add [eax],al
000092E2  0000              add [eax],al
000092E4  40                inc eax
000092E5  3A10              cmp dl,[eax]
000092E7  0000              add [eax],al
000092E9  0000              add [eax],al
000092EB  0003              add [ebx],al
000092ED  0003              add [ebx],al
000092EF  0000              add [eax],al
000092F1  0000              add [eax],al
000092F3  00703A            add [eax+0x3a],dh
000092F6  1000              adc [eax],al
000092F8  0000              add [eax],al
000092FA  0000              add [eax],al
000092FC  0300              add eax,[eax]
000092FE  0400              add al,0x0
00009300  0000              add [eax],al
00009302  0000              add [eax],al
00009304  707A              jo 0x9380
00009306  1000              adc [eax],al
00009308  0000              add [eax],al
0000930A  0000              add [eax],al
0000930C  0300              add eax,[eax]
0000930E  0500000000        add eax,0x0
00009313  0000              add [eax],al
00009315  90                nop
00009316  1000              adc [eax],al
00009318  0000              add [eax],al
0000931A  0000              add [eax],al
0000931C  0300              add eax,[eax]
0000931E  06                push es
0000931F  0000              add [eax],al
00009321  0000              add [eax],al
00009323  0000              add [eax],al
00009325  E010              loopne 0x9337
00009327  0000              add [eax],al
00009329  0000              add [eax],al
0000932B  0003              add [ebx],al
0000932D  0007              add [edi],al
0000932F  0000              add [eax],al
00009331  0000              add [eax],al
00009333  0064E110          add [ecx+0x10],ah
00009337  0000              add [eax],al
00009339  0000              add [eax],al
0000933B  0003              add [ebx],al
0000933D  0008              add [eax],cl
0000933F  0000              add [eax],al
00009341  0000              add [eax],al
00009343  0088E3100000      add [eax+0x10e3],cl
00009349  0000              add [eax],al
0000934B  0003              add [ebx],al
0000934D  0009              add [ecx],cl
0000934F  0000              add [eax],al
00009351  0000              add [eax],al
00009353  00EC              add ah,ch
00009355  EF                out dx,eax
00009356  1000              adc [eax],al
00009358  0000              add [eax],al
0000935A  0000              add [eax],al
0000935C  0300              add eax,[eax]
0000935E  0A00              or al,[eax]
00009360  0000              add [eax],al
00009362  0000              add [eax],al
00009364  0000              add [eax],al
00009366  0000              add [eax],al
00009368  0000              add [eax],al
0000936A  0000              add [eax],al
0000936C  0300              add eax,[eax]
0000936E  0B00              or eax,[eax]
00009370  0100              add [eax],eax
00009372  0000              add [eax],al
00009374  0000              add [eax],al
00009376  0000              add [eax],al
00009378  0000              add [eax],al
0000937A  0000              add [eax],al
0000937C  0400              add al,0x0
0000937E  F1                int1
0000937F  FF17              call dword [edi]
00009381  0000              add [eax],al
00009383  0001              add [ecx],al
00009385  0000              add [eax],al
00009387  0000              add [eax],al
00009389  0000              add [eax],al
0000938B  0000              add [eax],al
0000938D  00F1              add cl,dh
0000938F  FF1F              call dword far [edi]
00009391  0000              add [eax],al
00009393  0002              add [edx],al
00009395  0000              add [eax],al
00009397  0000              add [eax],al
00009399  0000              add [eax],al
0000939B  0000              add [eax],al
0000939D  00F1              add cl,dh
0000939F  FF27              jmp dword [edi]
000093A1  0000              add [eax],al
000093A3  0003              add [ebx],al
000093A5  0000              add [eax],al
000093A7  0000              add [eax],al
000093A9  0000              add [eax],al
000093AB  0000              add [eax],al
000093AD  00F1              add cl,dh
000093AF  FF2D00000002      jmp dword far [dword 0x2000000]
000093B5  B0AD              mov al,0xad
000093B7  1B00              sbb eax,[eax]
000093B9  0000              add [eax],al
000093BB  0000              add [eax],al
000093BD  00F1              add cl,dh
000093BF  FF33              push dword [ebx]
000093C1  0000              add [eax],al
000093C3  00FB              add bl,bh
000093C5  4F                dec edi
000093C6  52                push edx
000093C7  E400              in al,0x0
000093C9  0000              add [eax],al
000093CB  0000              add [eax],al
000093CD  00F1              add cl,dh
000093CF  FF                db 0xff
000093D0  3C00              cmp al,0x0
000093D2  0000              add [eax],al
000093D4  703A              jo 0x9410
000093D6  1000              adc [eax],al
000093D8  0000              add [eax],al
000093DA  0000              add [eax],al
000093DC  0000              add [eax],al
000093DE  0400              add al,0x0
000093E0  49                dec ecx
000093E1  0000              add [eax],al
000093E3  001B              add [ebx],bl
000093E5  0010              add [eax],dl
000093E7  0000              add [eax],al
000093E9  0000              add [eax],al
000093EB  0000              add [eax],al
000093ED  0001              add [ecx],al
000093EF  005500            add [ebp+0x0],dl
000093F2  0000              add [eax],al
000093F4  2500100000        and eax,0x1000
000093F9  0000              add [eax],al
000093FB  0000              add [eax],al
000093FD  0001              add [ecx],al
000093FF  005E00            add [esi+0x0],bl
00009402  0000              add [eax],al
00009404  4E                dec esi
00009405  0010              add [eax],dl
00009407  0000              add [eax],al
00009409  0000              add [eax],al
0000940B  0000              add [eax],al
0000940D  0001              add [ecx],al
0000940F  007200            add [edx+0x0],dh
00009412  0000              add [eax],al
00009414  009010000000      add [eax+0x10],dl
0000941A  0000              add [eax],al
0000941C  0000              add [eax],al
0000941E  06                push es
0000941F  007B00            add [ebx+0x0],bh
00009422  0000              add [eax],al
00009424  28D1              sub cl,dl
00009426  1000              adc [eax],al
00009428  0000              add [eax],al
0000942A  0000              add [eax],al
0000942C  0000              add [eax],al
0000942E  06                push es
0000942F  008500000060      add [ebp+0x60000000],al
00009435  D110              rcl dword [eax],1
00009437  0000              add [eax],al
00009439  0000              add [eax],al
0000943B  0000              add [eax],al
0000943D  0006              add [esi],al
0000943F  009000000064      add [eax+0x64000000],dl
00009445  D110              rcl dword [eax],1
00009447  0000              add [eax],al
00009449  0000              add [eax],al
0000944B  0000              add [eax],al
0000944D  0006              add [esi],al
0000944F  009C000000B6D1    add [eax+eax-0x2e4a0000],bl
00009456  1000              adc [eax],al
00009458  0000              add [eax],al
0000945A  0000              add [eax],al
0000945C  0000              add [eax],al
0000945E  06                push es
0000945F  00AD000000BE      add [ebp-0x42000000],ch
00009465  D110              rcl dword [eax],1
00009467  0000              add [eax],al
00009469  0000              add [eax],al
0000946B  0000              add [eax],al
0000946D  0006              add [esi],al
0000946F  00BB00000000      add [ebx+0x0],bh
00009475  0000              add [eax],al
00009477  0000              add [eax],al
00009479  0000              add [eax],al
0000947B  000400            add [eax+eax],al
0000947E  F1                int1
0000947F  FFC1              inc ecx
00009481  0000              add [eax],al
00009483  0000              add [eax],al
00009485  0000              add [eax],al
00009487  0000              add [eax],al
00009489  0000              add [eax],al
0000948B  000400            add [eax+eax],al
0000948E  F1                int1
0000948F  FFCF              dec edi
00009491  0000              add [eax],al
00009493  0000              add [eax],al
00009495  0000              add [eax],al
00009497  0000              add [eax],al
00009499  0000              add [eax],al
0000949B  000400            add [eax+eax],al
0000949E  F1                int1
0000949F  FFD6              call esi
000094A1  0000              add [eax],al
000094A3  0000              add [eax],al
000094A5  0000              add [eax],al
000094A7  0000              add [eax],al
000094A9  0000              add [eax],al
000094AB  000400            add [eax+eax],al
000094AE  F1                int1
000094AF  FF                db 0xff
000094B0  E900000000        jmp dword 0x94b5
000094B5  0000              add [eax],al
000094B7  0000              add [eax],al
000094B9  0000              add [eax],al
000094BB  000400            add [eax+eax],al
000094BE  F1                int1
000094BF  FF                db 0xff
000094C0  FE00              inc byte [eax]
000094C2  0000              add [eax],al
000094C4  0000              add [eax],al
000094C6  0000              add [eax],al
000094C8  0000              add [eax],al
000094CA  0000              add [eax],al
000094CC  0400              add al,0x0
000094CE  F1                int1
000094CF  FF0B              dec dword [ebx]
000094D1  0100              add [eax],eax
000094D3  0000              add [eax],al
000094D5  0000              add [eax],al
000094D7  0000              add [eax],al
000094D9  0000              add [eax],al
000094DB  000400            add [eax+eax],al
000094DE  F1                int1
000094DF  FF12              call dword [edx]
000094E1  0100              add [eax],eax
000094E3  0020              add [eax],ah
000094E5  361000            adc [ss:eax],al
000094E8  2000              and [eax],al
000094EA  0000              add [eax],al
000094EC  0100              add [eax],eax
000094EE  0200              add al,[eax]
000094F0  1B01              sbb eax,[ecx]
000094F2  0000              add [eax],al
000094F4  0036              add [esi],dh
000094F6  1000              adc [eax],al
000094F8  2000              and [eax],al
000094FA  0000              add [eax],al
000094FC  0100              add [eax],eax
000094FE  0200              add al,[eax]
00009500  2401              and al,0x1
00009502  0000              add [eax],al
00009504  E035              loopne 0x953b
00009506  1000              adc [eax],al
00009508  2000              and [eax],al
0000950A  0000              add [eax],al
0000950C  0100              add [eax],eax
0000950E  0200              add al,[eax]
00009510  2D01000000        sub eax,0x1
00009515  E010              loopne 0x9527
00009517  0011              add [ecx],dl
00009519  0000              add [eax],al
0000951B  0001              add [ecx],al
0000951D  0007              add [edi],al
0000951F  003501000000      add [dword 0x1],dh
00009525  0000              add [eax],al
00009527  0000              add [eax],al
00009529  0000              add [eax],al
0000952B  000400            add [eax+eax],al
0000952E  F1                int1
0000952F  FF                db 0xff
00009530  3E0100            add [ds:eax],eax
00009533  0000              add [eax],al
00009535  0000              add [eax],al
00009537  0000              add [eax],al
00009539  0000              add [eax],al
0000953B  000400            add [eax+eax],al
0000953E  F1                int1
0000953F  FF4301            inc dword [ebx+0x1]
00009542  0000              add [eax],al
00009544  0000              add [eax],al
00009546  0000              add [eax],al
00009548  0000              add [eax],al
0000954A  0000              add [eax],al
0000954C  0400              add al,0x0
0000954E  F1                int1
0000954F  FF4901            dec dword [ecx+0x1]
00009552  0000              add [eax],al
00009554  0000              add [eax],al
00009556  0000              add [eax],al
00009558  0000              add [eax],al
0000955A  0000              add [eax],al
0000955C  0400              add al,0x0
0000955E  F1                int1
0000955F  FF540100          call dword [ecx+eax+0x0]
00009563  004036            add [eax+0x36],al
00009566  1000              adc [eax],al
00009568  000400            add [eax+eax],al
0000956B  0001              add [ecx],al
0000956D  0002              add [edx],al
0000956F  005D01            add [ebp+0x1],bl
00009572  0000              add [eax],al
00009574  300F              xor [edi],cl
00009576  1000              adc [eax],al
00009578  0F0000            sldt [eax]
0000957B  0012              add [edx],dl
0000957D  0001              add [ecx],al
0000957F  006B01            add [ebx+0x1],ch
00009582  0000              add [eax],al
00009584  800D1000090000    or byte [dword 0x90010],0x0
0000958B  0012              add [edx],dl
0000958D  0001              add [ecx],al
0000958F  007501            add [ebp+0x1],dh
00009592  0000              add [eax],al
00009594  803310            xor byte [ebx],0x10
00009597  000400            add [eax+eax],al
0000959A  0000              add [eax],al
0000959C  1100              adc [eax],eax
0000959E  0200              add al,[eax]
000095A0  800100            add byte [ecx],0x0
000095A3  0038              add [eax],bh
000095A5  90                nop
000095A6  1000              adc [eax],al
000095A8  0000              add [eax],al
000095AA  0000              add [eax],al
000095AC  1000              adc [eax],al
000095AE  06                push es
000095AF  008601000000      add [esi+0x1],al
000095B5  3110              xor [eax],edx
000095B7  000400            add [eax+eax],al
000095BA  0000              add [eax],al
000095BC  1100              adc [eax],eax
000095BE  0200              add al,[eax]
000095C0  8E01              mov es,[ecx]
000095C2  0000              add [eax],al
000095C4  7082              jo 0x9548
000095C6  1000              adc [eax],al
000095C8  0000              add [eax],al
000095CA  0000              add [eax],al
000095CC  1000              adc [eax],al
000095CE  05009C0100        add eax,0x19c00
000095D3  0006              add [esi],al
000095D5  90                nop
000095D6  1000              adc [eax],al
000095D8  0000              add [eax],al
000095DA  0000              add [eax],al
000095DC  1000              adc [eax],al
000095DE  06                push es
000095DF  00A40100004033    add [ecx+eax+0x33400000],ah
000095E6  1000              adc [eax],al
000095E8  0100              add [eax],eax
000095EA  0000              add [eax],al
000095EC  1100              adc [eax],eax
000095EE  0200              add al,[eax]
000095F0  B301              mov bl,0x1
000095F2  0000              add [eax],al
000095F4  700F              jo 0x9605
000095F6  1000              adc [eax],al
000095F8  0F0000            sldt [eax]
000095FB  0012              add [edx],dl
000095FD  0001              add [ecx],al
000095FF  00C2              add dl,al
00009601  0100              add [eax],eax
00009603  004031            add [eax+0x31],al
00009606  1000              adc [eax],al
00009608  FF00              inc dword [eax]
0000960A  0000              add [eax],al
0000960C  1100              adc [eax],eax
0000960E  0200              add al,[eax]
00009610  CB                retf
00009611  0100              add [eax],eax
00009613  007ED1            add [esi-0x2f],bh
00009616  1000              adc [eax],al
00009618  0000              add [eax],al
0000961A  0000              add [eax],al
0000961C  1000              adc [eax],al
0000961E  06                push es
0000961F  00D7              add bh,dl
00009621  0100              add [eax],eax
00009623  0028              add [eax],ch
00009625  91                xchg eax,ecx
00009626  1000              adc [eax],al
00009628  0000              add [eax],al
0000962A  0000              add [eax],al
0000962C  1000              adc [eax],al
0000962E  06                push es
0000962F  00DD              add ch,bl
00009631  0100              add [eax],eax
00009633  00403A            add [eax+0x3a],al
00009636  1000              adc [eax],al
00009638  0000              add [eax],al
0000963A  0000              add [eax],al
0000963C  1000              adc [eax],al
0000963E  0300              add eax,[eax]
00009640  E501              in eax,0x1
00009642  0000              add [eax],al
00009644  C00E10            ror byte [esi],byte 0x10
00009647  000F              add [edi],cl
00009649  0000              add [eax],al
0000964B  0012              add [edx],dl
0000964D  0001              add [ecx],al
0000964F  00F3              add bl,dh
00009651  0100              add [eax],eax
00009653  009E90100000      add [esi+0x1090],bl
00009659  0000              add [eax],al
0000965B  0010              add [eax],dl
0000965D  0006              add [esi],al
0000965F  00F9              add cl,bh
00009661  0100              add [eax],eax
00009663  0027              add [edi],ah
00009665  90                nop
00009666  1000              adc [eax],al
00009668  0000              add [eax],al
0000966A  0000              add [eax],al
0000966C  1000              adc [eax],al
0000966E  06                push es
0000966F  00FF              add bh,bh
00009671  0100              add [eax],eax
00009673  006B90            add [ebx-0x70],ch
00009676  1000              adc [eax],al
00009678  0000              add [eax],al
0000967A  0000              add [eax],al
0000967C  1000              adc [eax],al
0000967E  06                push es
0000967F  0005020000A0      add [dword 0xa0000002],al
00009685  0F1000            movups xmm0,oword [eax]
00009688  A900000012        test eax,0x12000000
0000968D  0001              add [ecx],al
0000968F  001B              add [ebx],bl
00009691  0200              add al,[eax]
00009693  0010              add [eax],dl
00009695  1C10              sbb al,0x10
00009697  007A00            add [edx+0x0],bh
0000969A  0000              add [eax],al
0000969C  1200              adc al,[eax]
0000969E  0100              add [eax],eax
000096A0  2A02              sub al,[edx]
000096A2  0000              add [eax],al
000096A4  000F              add [edi],cl
000096A6  1000              adc [eax],al
000096A8  0F0000            sldt [eax]
000096AB  0012              add [edx],dl
000096AD  0001              add [ecx],al
000096AF  0038              add [eax],bh
000096B1  0200              add al,[eax]
000096B3  00500F            add [eax+0xf],dl
000096B6  1000              adc [eax],al
000096B8  0F0000            sldt [eax]
000096BB  0012              add [edx],dl
000096BD  0001              add [ecx],al
000096BF  004702            add [edi+0x2],al
000096C2  0000              add [eax],al
000096C4  B010              mov al,0x10
000096C6  1000              adc [eax],al
000096C8  3400              xor al,0x0
000096CA  0000              add [eax],al
000096CC  1200              adc al,[eax]
000096CE  0100              add [eax],eax
000096D0  4E                dec esi
000096D1  0200              add al,[eax]
000096D3  00640010          add [eax+eax+0x10],ah
000096D7  0000              add [eax],al
000096D9  0000              add [eax],al
000096DB  0010              add [eax],dl
000096DD  0001              add [ecx],al
000096DF  005802            add [eax+0x2],bl
000096E2  0000              add [eax],al
000096E4  90                nop
000096E5  17                pop ss
000096E6  1000              adc [eax],al
000096E8  2D00000012        sub eax,0x12000000
000096ED  0001              add [ecx],al
000096EF  006702            add [edi+0x2],ah
000096F2  0000              add [eax],al
000096F4  C01910            rcr byte [ecx],byte 0x10
000096F7  003C00            add [eax+eax],bh
000096FA  0000              add [eax],al
000096FC  1200              adc al,[eax]
000096FE  0100              add [eax],eax
00009700  7C02              jl 0x9704
00009702  0000              add [eax],al
00009704  F00E              lock push cs
00009706  1000              adc [eax],al
00009708  0F0000            sldt [eax]
0000970B  0012              add [edx],dl
0000970D  0001              add [ecx],al
0000970F  008A02000050      add [edx+0x50000002],cl
00009715  1310              adc edx,[eax]
00009717  0017              add [edi],dl
00009719  0000              add [eax],al
0000971B  0012              add [edx],dl
0000971D  0001              add [ecx],al
0000971F  009202000080      add [edx-0x7ffffffe],dl
00009725  2010              and [eax],dl
00009727  000400            add [eax+eax],al
0000972A  0000              add [eax],al
0000972C  1100              adc [eax],eax
0000972E  0200              add al,[eax]
00009730  9F                lahf
00009731  0200              add al,[eax]
00009733  0020              add [eax],ah
00009735  1310              adc edx,[eax]
00009737  000D00000012      add [dword 0x12000000],cl
0000973D  0001              add [ecx],al
0000973F  00A7020000C0      add [edi-0x3ffffffe],ah
00009745  90                nop
00009746  1000              adc [eax],al
00009748  0000              add [eax],al
0000974A  0000              add [eax],al
0000974C  1000              adc [eax],al
0000974E  06                push es
0000974F  00AE02000015      add [esi+0x15000002],ch
00009755  91                xchg eax,ecx
00009756  1000              adc [eax],al
00009758  0000              add [eax],al
0000975A  0000              add [eax],al
0000975C  1000              adc [eax],al
0000975E  06                push es
0000975F  00B502000070      add [ebp+0x70000002],dh
00009765  1B10              sbb edx,[eax]
00009767  004900            add [ecx+0x0],cl
0000976A  0000              add [eax],al
0000976C  1200              adc al,[eax]
0000976E  0100              add [eax],eax
00009770  C3                ret
00009771  0200              add al,[eax]
00009773  0000              add [eax],al
00009775  0110              add [eax],edx
00009777  00A100000012      add [ecx+0x12000000],ah
0000977D  0001              add [ecx],al
0000977F  00CE              add dh,cl
00009781  0200              add al,[eax]
00009783  00E2              add dl,ah
00009785  90                nop
00009786  1000              adc [eax],al
00009788  0000              add [eax],al
0000978A  0000              add [eax],al
0000978C  1000              adc [eax],al
0000978E  06                push es
0000978F  00D5              add ch,dl
00009791  0200              add al,[eax]
00009793  006C0010          add [eax+eax+0x10],ch
00009797  0000              add [eax],al
00009799  0000              add [eax],al
0000979B  0010              add [eax],dl
0000979D  0001              add [ecx],al
0000979F  00DF              add bh,bl
000097A1  0200              add al,[eax]
000097A3  0068D1            add [eax-0x2f],ch
000097A6  1000              adc [eax],al
000097A8  0000              add [eax],al
000097AA  0000              add [eax],al
000097AC  1000              adc [eax],al
000097AE  06                push es
000097AF  00EB              add bl,ch
000097B1  0200              add al,[eax]
000097B3  0028              add [eax],ch
000097B5  D110              rcl dword [eax],1
000097B7  0000              add [eax],al
000097B9  0000              add [eax],al
000097BB  0010              add [eax],dl
000097BD  0006              add [esi],al
000097BF  00F1              add cl,dh
000097C1  0200              add al,[eax]
000097C3  00C0              add al,al
000097C5  2010              and [eax],dl
000097C7  0000              add [eax],al
000097C9  0800              or [eax],al
000097CB  0011              add [ecx],dl
000097CD  0002              add [edx],al
000097CF  00FC              add ah,bh
000097D1  0200              add al,[eax]
000097D3  008000100077      add [eax+0x77001000],al
000097D9  0000              add [eax],al
000097DB  0012              add [edx],dl
000097DD  0001              add [ecx],al
000097DF  0008              add [eax],cl
000097E1  0300              add eax,[eax]
000097E3  008003100035      add [eax+0x35001003],al
000097E9  06                push es
000097EA  0000              add [eax],al
000097EC  1200              adc al,[eax]
000097EE  0100              add [eax],eax
000097F0  150300002B        adc eax,0x2b000003
000097F5  0010              add [eax],dl
000097F7  0000              add [eax],al
000097F9  0000              add [eax],al
000097FB  0010              add [eax],dl
000097FD  0001              add [ecx],al
000097FF  0023              add [ebx],ah
00009801  0300              add eax,[eax]
00009803  0020              add [eax],ah
00009805  17                pop ss
00009806  1000              adc [eax],al
00009808  1000              adc [eax],al
0000980A  0000              add [eax],al
0000980C  1200              adc al,[eax]
0000980E  0100              add [eax],eax
00009810  3103              xor [ebx],eax
00009812  0000              add [eax],al
00009814  8433              test [ebx],dh
00009816  1000              adc [eax],al
00009818  0100              add [eax],eax
0000981A  0000              add [eax],al
0000981C  1100              adc [eax],eax
0000981E  0200              add al,[eax]
00009820  41                inc ecx
00009821  0300              add eax,[eax]
00009823  00F2              add dl,dh
00009825  D110              rcl dword [eax],1
00009827  0000              add [eax],al
00009829  0000              add [eax],al
0000982B  0010              add [eax],dl
0000982D  0006              add [esi],al
0000982F  004E03            add [esi+0x3],cl
00009832  0000              add [eax],al
00009834  000E              add [esi],cl
00009836  1000              adc [eax],al
00009838  670000            add [bx+si],al
0000983B  0012              add [edx],dl
0000983D  0001              add [ecx],al
0000983F  005803            add [eax+0x3],bl
00009842  0000              add [eax],al
00009844  C01110            rcl byte [ecx],byte 0x10
00009847  008900000012      add [ecx+0x12000000],cl
0000984D  0001              add [ecx],al
0000984F  006103            add [ecx+0x3],ah
00009852  0000              add [eax],al
00009854  49                dec ecx
00009855  90                nop
00009856  1000              adc [eax],al
00009858  0000              add [eax],al
0000985A  0000              add [eax],al
0000985C  1000              adc [eax],al
0000985E  06                push es
0000985F  006703            add [edi+0x3],ah
00009862  0000              add [eax],al
00009864  11D2              adc edx,edx
00009866  1000              adc [eax],al
00009868  0000              add [eax],al
0000986A  0000              add [eax],al
0000986C  1000              adc [eax],al
0000986E  06                push es
0000986F  007603            add [esi+0x3],dh
00009872  0000              add [eax],al
00009874  60                pushad
00009875  1810              sbb [eax],dl
00009877  005801            add [eax+0x1],bl
0000987A  0000              add [eax],al
0000987C  1200              adc al,[eax]
0000987E  0100              add [eax],eax
00009880  8703              xchg eax,[ebx]
00009882  0000              add [eax],al
00009884  60                pushad
00009885  0A10              or dl,[eax]
00009887  006700            add [edi+0x0],ah
0000988A  0000              add [eax],al
0000988C  1200              adc al,[eax]
0000988E  0100              add [eax],eax
00009890  93                xchg eax,ebx
00009891  0300              add eax,[eax]
00009893  0020              add [eax],ah
00009895  0310              add edx,[eax]
00009897  005200            add [edx+0x0],dl
0000989A  0000              add [eax],al
0000989C  1200              adc al,[eax]
0000989E  0100              add [eax],eax
000098A0  A003000000        mov al,[0x3]
000098A5  0A10              or dl,[eax]
000098A7  004800            add [eax+0x0],cl
000098AA  0000              add [eax],al
000098AC  1200              adc al,[eax]
000098AE  0100              add [eax],eax
000098B0  AF                scasd
000098B1  0300              add eax,[eax]
000098B3  00703A            add [eax+0x3a],dh
000098B6  1000              adc [eax],al
000098B8  0000              add [eax],al
000098BA  0000              add [eax],al
000098BC  1000              adc [eax],al
000098BE  0300              add eax,[eax]
000098C0  BB030000C0        mov ebx,0xc0000003
000098C5  2810              sub [eax],dl
000098C7  000400            add [eax+eax],al
000098CA  0000              add [eax],al
000098CC  1100              adc [eax],eax
000098CE  0200              add al,[eax]
000098D0  C7030000C435      mov dword [ebx],0x35c40000
000098D6  1000              adc [eax],al
000098D8  0400              add al,0x0
000098DA  0000              add [eax],al
000098DC  1100              adc [eax],eax
000098DE  0200              add al,[eax]
000098E0  D003              rol byte [ebx],1
000098E2  0000              add [eax],al
000098E4  E00E              loopne 0x98f4
000098E6  1000              adc [eax],al
000098E8  0F0000            sldt [eax]
000098EB  0012              add [edx],dl
000098ED  0001              add [ecx],al
000098EF  00DE              add dh,bl
000098F1  0300              add eax,[eax]
000098F3  00A00E10001A      add [eax+0x1a00100e],ah
000098F9  0000              add [eax],al
000098FB  0012              add [edx],dl
000098FD  0001              add [ecx],al
000098FF  00EA              add dl,ch
00009901  0300              add eax,[eax]
00009903  00C0              add al,al
00009905  0910              or [eax],edx
00009907  002B              add [ebx],ch
00009909  0000              add [eax],al
0000990B  0012              add [edx],dl
0000990D  0001              add [ecx],al
0000990F  00F8              add al,bh
00009911  0300              add eax,[eax]
00009913  00D0              add al,dl
00009915  1B10              sbb edx,[eax]
00009917  003A              add [edx],bh
00009919  0000              add [eax],al
0000991B  0012              add [edx],dl
0000991D  0001              add [ecx],al
0000991F  0006              add [esi],al
00009921  0400              add al,0x0
00009923  00C0              add al,al
00009925  17                pop ss
00009926  1000              adc [eax],al
00009928  0A00              or al,[eax]
0000992A  0000              add [eax],al
0000992C  1200              adc al,[eax]
0000992E  0100              add [eax],eax
00009930  180400            sbb [eax+eax],al
00009933  00D0              add al,dl
00009935  0A10              or dl,[eax]
00009937  00B100000012      add [ecx+0x12000000],dh
0000993D  0001              add [ecx],al
0000993F  0029              add [ecx],ch
00009941  0400              add al,0x0
00009943  0030              add [eax],dh
00009945  17                pop ss
00009946  1000              adc [eax],al
00009948  59                pop ecx
00009949  0000              add [eax],al
0000994B  0012              add [edx],dl
0000994D  0001              add [ecx],al
0000994F  003D04000050      add [dword 0x50000004],bh
00009955  1210              adc dl,[eax]
00009957  00B700000012      add [edi+0x12000000],dh
0000995D  0001              add [ecx],al
0000995F  004604            add [esi+0x4],al
00009962  0000              add [eax],al
00009964  1017              adc [edi],dl
00009966  1000              adc [eax],al
00009968  0D00000012        or eax,0x12000000
0000996D  0001              add [ecx],al
0000996F  005104            add [ecx+0x4],dl
00009972  0000              add [eax],al
00009974  1000              adc [eax],al
00009976  1000              adc [eax],al
00009978  0000              add [eax],al
0000997A  0000              add [eax],al
0000997C  1000              adc [eax],al
0000997E  0100              add [eax],eax
00009980  58                pop eax
00009981  0400              add al,0x0
00009983  00600F            add [eax+0xf],ah
00009986  1000              adc [eax],al
00009988  0F0000            sldt [eax]
0000998B  0012              add [edx],dl
0000998D  0001              add [ecx],al
0000998F  006704            add [edi+0x4],ah
00009992  0000              add [eax],al
00009994  C428              les ebp,[eax]
00009996  1000              adc [eax],al
00009998  0400              add al,0x0
0000999A  0000              add [eax],al
0000999C  1100              adc [eax],eax
0000999E  0200              add al,[eax]
000099A0  7204              jc 0x99a6
000099A2  0000              add [eax],al
000099A4  F390              pause
000099A6  1000              adc [eax],al
000099A8  0000              add [eax],al
000099AA  0000              add [eax],al
000099AC  1000              adc [eax],al
000099AE  06                push es
000099AF  007904            add [ecx+0x4],bh
000099B2  0000              add [eax],al
000099B4  3013              xor [ebx],dl
000099B6  1000              adc [eax],al
000099B8  17                pop ss
000099B9  0000              add [eax],al
000099BB  0012              add [edx],dl
000099BD  0001              add [ecx],al
000099BF  0081040000C8      add [ecx-0x37fffffc],al
000099C5  2810              sub [eax],dl
000099C7  000400            add [eax+eax],al
000099CA  0000              add [eax],al
000099CC  1100              adc [eax],eax
000099CE  0200              add al,[eax]
000099D0  8B0400            mov eax,[eax+eax]
000099D3  00443310          add [ebx+esi+0x10],al
000099D7  000400            add [eax+eax],al
000099DA  0000              add [eax],al
000099DC  1100              adc [eax],eax
000099DE  0200              add al,[eax]
000099E0  9B0400            wait add al,0x0
000099E3  00900D100003      add [eax+0x300100d],dl
000099E9  0000              add [eax],al
000099EB  0012              add [edx],dl
000099ED  0001              add [ecx],al
000099EF  00B10400008D      add [ecx-0x72fffffc],dh
000099F5  90                nop
000099F6  1000              adc [eax],al
000099F8  0000              add [eax],al
000099FA  0000              add [eax],al
000099FC  1000              adc [eax],al
000099FE  06                push es
000099FF  00B704000070      add [edi+0x70000004],dh
00009A05  7A10              jpe 0x9a17
00009A07  0000              add [eax],al
00009A09  0000              add [eax],al
00009A0B  0010              add [eax],dl
00009A0D  000400            add [eax+eax],al
00009A10  C1040000          rol dword [eax+eax],byte 0x0
00009A14  5A                pop edx
00009A15  90                nop
00009A16  1000              adc [eax],al
00009A18  0000              add [eax],al
00009A1A  0000              add [eax],al
00009A1C  1000              adc [eax],al
00009A1E  06                push es
00009A1F  00C7              add bh,al
00009A21  0400              add al,0x0
00009A23  008833100004      add [eax+0x4001033],cl
00009A29  0000              add [eax],al
00009A2B  0011              add [ecx],dl
00009A2D  0002              add [edx],al
00009A2F  00D2              add dl,dl
00009A31  0400              add al,0x0
00009A33  0090131000F9      add [eax-0x6ffefed],dl
00009A39  0000              add [eax],al
00009A3B  0012              add [edx],dl
00009A3D  0001              add [ecx],al
00009A3F  00E2              add dl,ah
00009A41  0400              add al,0x0
00009A43  00F0              add al,dh
00009A45  0910              or [eax],edx
00009A47  000B              add [ebx],cl
00009A49  0000              add [eax],al
00009A4B  0012              add [edx],dl
00009A4D  0001              add [ecx],al
00009A4F  00F3              add bl,dh
00009A51  0400              add al,0x0
00009A53  00800E10001A      add [eax+0x1a00100e],al
00009A59  0000              add [eax],al
00009A5B  0012              add [edx],dl
00009A5D  0001              add [ecx],al
00009A5F  00FF              add bh,bh
00009A61  0400              add al,0x0
00009A63  008C3310000400    add [ebx+esi+0x40010],cl
00009A6A  0000              add [eax],al
00009A6C  1100              adc [eax],eax
00009A6E  0200              add al,[eax]
00009A70  0A0500005010      or al,[dword 0x10500000]
00009A76  1000              adc [eax],al
00009A78  1C00              sbb al,0x0
00009A7A  0000              add [eax],al
00009A7C  1200              adc al,[eax]
00009A7E  0100              add [eax],eax
00009A80  21050000900B      and [dword 0xb900000],eax
00009A86  1000              adc [eax],al
00009A88  3800              cmp [eax],al
00009A8A  0000              add [eax],al
00009A8C  1200              adc al,[eax]
00009A8E  0100              add [eax],eax
00009A90  2C05              sub al,0x5
00009A92  0000              add [eax],al
00009A94  F01010            lock adc [eax],dl
00009A97  002D00000012      add [dword 0x12000000],ch
00009A9D  0001              add [ecx],al
00009A9F  0033              add [ebx],dh
00009AA1  050000C033        add eax,0x33c00000
00009AA6  1000              adc [eax],al
00009AA8  FF00              inc dword [eax]
00009AAA  0000              add [eax],al
00009AAC  1100              adc [eax],eax
00009AAE  0200              add al,[eax]
00009AB0  41                inc ecx
00009AB1  050000400F        add eax,0xf400000
00009AB6  1000              adc [eax],al
00009AB8  0F0000            sldt [eax]
00009ABB  0012              add [edx],dl
00009ABD  0001              add [ecx],al
00009ABF  005005            add [eax+0x5],dl
00009AC2  0000              add [eax],al
00009AC4  C01B10            rcr byte [ebx],byte 0x10
00009AC7  000F              add [edi],cl
00009AC9  0000              add [eax],al
00009ACB  0012              add [edx],dl
00009ACD  0001              add [ecx],al
00009ACF  006505            add [ebp+0x5],ah
00009AD2  0000              add [eax],al
00009AD4  40                inc eax
00009AD5  3210              xor dl,[eax]
00009AD7  00FF              add bh,bh
00009AD9  0000              add [eax],al
00009ADB  0011              add [ecx],dl
00009ADD  0002              add [edx],al
00009ADF  006E05            add [esi+0x5],ch
00009AE2  0000              add [eax],al
00009AE4  90                nop
00009AE5  1C10              sbb al,0x10
00009AE7  006300            add [ebx+0x0],ah
00009AEA  0000              add [eax],al
00009AEC  1200              adc al,[eax]
00009AEE  0100              add [eax],eax
00009AF0  7605              jna 0x9af7
00009AF2  0000              add [eax],al
00009AF4  1E                push ds
00009AF5  0010              add [eax],dl
00009AF7  0000              add [eax],al
00009AF9  0000              add [eax],al
00009AFB  0010              add [eax],dl
00009AFD  0001              add [ecx],al
00009AFF  008305000026      add [ebx+0x26000005],al
00009B05  91                xchg eax,ecx
00009B06  1000              adc [eax],al
00009B08  0000              add [eax],al
00009B0A  0000              add [eax],al
00009B0C  1000              adc [eax],al
00009B0E  06                push es
00009B0F  008B05000000      add [ebx+0x5],cl
00009B15  1810              sbb [eax],dl
00009B17  005E00            add [esi+0x0],bl
00009B1A  0000              add [eax],al
00009B1C  1200              adc al,[eax]
00009B1E  0100              add [eax],eax
00009B20  9C                pushfd
00009B21  050000001A        add eax,0x1a000000
00009B26  1000              adc [eax],al
00009B28  0300              add eax,[eax]
00009B2A  0000              add [eax],al
00009B2C  1200              adc al,[eax]
00009B2E  0100              add [eax],eax
00009B30  A305000090        mov [0x90000005],eax
00009B35  0F1000            movups xmm0,oword [eax]
00009B38  0F0000            sldt [eax]
00009B3B  0012              add [edx],dl
00009B3D  0001              add [ecx],al
00009B3F  00B205000070      add [edx+0x70000005],dh
00009B45  1310              adc edx,[eax]
00009B47  0016              add [esi],dl
00009B49  0000              add [eax],al
00009B4B  0012              add [edx],dl
00009B4D  0001              add [ecx],al
00009B4F  00BA050000D0      add [edx-0x2ffffffb],bh
00009B55  0B10              or edx,[eax]
00009B57  008C0100001200    add [ecx+eax+0x120000],cl
00009B5E  0100              add [eax],eax
00009B60  C5050000700D      lds eax,[dword 0xd700000]
00009B66  1000              adc [eax],al
00009B68  0A00              or al,[eax]
00009B6A  0000              add [eax],al
00009B6C  1200              adc al,[eax]
00009B6E  0100              add [eax],eax
00009B70  D405              aam 0x5
00009B72  0000              add [eax],al
00009B74  B001              mov al,0x1
00009B76  1000              adc [eax],al
00009B78  53                push ebx
00009B79  0000              add [eax],al
00009B7B  0012              add [edx],dl
00009B7D  0001              add [ecx],al
00009B7F  00DF              add bh,bl
00009B81  0500007400        add eax,0x740000
00009B86  1000              adc [eax],al
00009B88  0000              add [eax],al
00009B8A  0000              add [eax],al
00009B8C  1000              adc [eax],al
00009B8E  0100              add [eax],eax
00009B90  EB05              jmp short 0x9b97
00009B92  0000              add [eax],al
00009B94  6C                insb
00009B95  D110              rcl dword [eax],1
00009B97  0000              add [eax],al
00009B99  0000              add [eax],al
00009B9B  0010              add [eax],dl
00009B9D  0006              add [esi],al
00009B9F  00F5              add ch,dh
00009BA1  0500004833        add eax,0x33480000
00009BA6  1000              adc [eax],al
00009BA8  0400              add al,0x0
00009BAA  0000              add [eax],al
00009BAC  1100              adc [eax],eax
00009BAE  0200              add al,[eax]
00009BB0  0506000080        add eax,0x80000006
00009BB5  0F1000            movups xmm0,oword [eax]
00009BB8  0F0000            sldt [eax]
00009BBB  0012              add [edx],dl
00009BBD  0001              add [ecx],al
00009BBF  001406            add [esi+eax],dl
00009BC2  0000              add [eax],al
00009BC4  40                inc eax
00009BC5  D210              rcl byte [eax],cl
00009BC7  000400            add [eax+eax],al
00009BCA  0000              add [eax],al
00009BCC  1100              adc [eax],eax
00009BCE  06                push es
00009BCF  0020              add [eax],ah
00009BD1  06                push es
00009BD2  0000              add [eax],al
00009BD4  EAD11000000000    jmp dword 0x0:0x10d1
00009BDB  0010              add [eax],dl
00009BDD  0006              add [esi],al
00009BDF  002C06            add [esi+eax],ch
00009BE2  0000              add [eax],al
00009BE4  001D10000F01      add [dword 0x10f0010],bl
00009BEA  0000              add [eax],al
00009BEC  1200              adc al,[eax]
00009BEE  0100              add [eax],eax
00009BF0  40                inc eax
00009BF1  06                push es
00009BF2  0000              add [eax],al
00009BF4  D00D10002200      ror byte [dword 0x220010],1
00009BFA  0000              add [eax],al
00009BFC  1200              adc al,[eax]
00009BFE  0100              add [eax],eax
00009C00  4F                dec edi
00009C01  06                push es
00009C02  0000              add [eax],al
00009C04  AF                scasd
00009C05  90                nop
00009C06  1000              adc [eax],al
00009C08  0000              add [eax],al
00009C0A  0000              add [eax],al
00009C0C  1000              adc [eax],al
00009C0E  06                push es
00009C0F  005506            add [ebp+0x6],dl
00009C12  0000              add [eax],al
00009C14  642010            and [fs:eax],dl
00009C17  000400            add [eax+eax],al
00009C1A  0000              add [eax],al
00009C1C  1100              adc [eax],eax
00009C1E  0200              add al,[eax]
00009C20  61                popad
00009C21  06                push es
00009C22  0000              add [eax],al
00009C24  60                pushad
00009C25  0D10000600        or eax,0x60010
00009C2A  0000              add [eax],al
00009C2C  1200              adc al,[eax]
00009C2E  0100              add [eax],eax
00009C30  6A06              push byte +0x6
00009C32  0000              add [eax],al
00009C34  0029              add [ecx],ch
00009C36  1000              adc [eax],al
00009C38  0008              add [eax],cl
00009C3A  0000              add [eax],al
00009C3C  1100              adc [eax],eax
00009C3E  0200              add al,[eax]
00009C40  81060000E014      add dword [esi],0x14e00000
00009C46  1000              adc [eax],al
00009C48  2E0200            add al,[cs:eax]
00009C4B  0012              add [edx],dl
00009C4D  0001              add [ecx],al
00009C4F  008906000010      add [ecx+0x10000006],cl
00009C55  0210              add dl,[eax]
00009C57  0003              add [ebx],al
00009C59  0100              add [eax],eax
00009C5B  0012              add [edx],dl
00009C5D  0001              add [ecx],al
00009C5F  009806000070      add [eax+0x70000006],bl
00009C65  0E                push cs
00009C66  1000              adc [eax],al
00009C68  0500000012        add eax,0x12000000
00009C6D  0001              add [ecx],al
00009C6F  00A4060000200F    add [esi+eax+0xf200000],ah
00009C76  1000              adc [eax],al
00009C78  0F0000            sldt [eax]
00009C7B  0012              add [edx],dl
00009C7D  0001              add [ecx],al
00009C7F  00B20600007C      add [edx+0x7c000006],dh
00009C85  90                nop
00009C86  1000              adc [eax],al
00009C88  0000              add [eax],al
00009C8A  0000              add [eax],al
00009C8C  1000              adc [eax],al
00009C8E  06                push es
00009C8F  00B806000070      add [eax+0x70000006],bh
00009C95  1010              adc [eax],dl
00009C97  001B              add [ebx],bl
00009C99  0000              add [eax],al
00009C9B  0012              add [edx],dl
00009C9D  0001              add [ecx],al
00009C9F  00D2              add dl,dl
00009CA1  06                push es
00009CA2  0000              add [eax],al
00009CA4  80D210            adc dl,0x10
00009CA7  004000            add [eax+0x0],al
00009CAA  0000              add [eax],al
00009CAC  1100              adc [eax],eax
00009CAE  06                push es
00009CAF  00DA              add dl,bl
00009CB1  06                push es
00009CB2  0000              add [eax],al
00009CB4  D19010000000      rcl dword [eax+0x10],1
00009CBA  0000              add [eax],al
00009CBC  1000              adc [eax],al
00009CBE  06                push es
00009CBF  00E1              add cl,ah
00009CC1  06                push es
00009CC2  0000              add [eax],al
00009CC4  707A              jo 0x9d40
00009CC6  1000              adc [eax],al
00009CC8  0000              add [eax],al
00009CCA  0000              add [eax],al
00009CCC  1000              adc [eax],al
00009CCE  0500EB0600        add eax,0x6eb00
00009CD3  000491            add [ecx+edx*4],al
00009CD6  1000              adc [eax],al
00009CD8  0000              add [eax],al
00009CDA  0000              add [eax],al
00009CDC  1000              adc [eax],al
00009CDE  06                push es
00009CDF  00F2              add dl,dh
00009CE1  06                push es
00009CE2  0000              add [eax],al
00009CE4  90                nop
00009CE5  1010              adc [eax],dl
00009CE7  001D00000012      add [dword 0x12000000],bl
00009CED  0001              add [ecx],al
00009CEF  00F9              add cl,bh
00009CF1  06                push es
00009CF2  0000              add [eax],al
00009CF4  1013              adc [ebx],dl
00009CF6  1000              adc [eax],al
00009CF8  0D00000012        or eax,0x12000000
00009CFD  0001              add [ecx],al
00009CFF  0001              add [ecx],al
00009D01  07                pop es
00009D02  0000              add [eax],al
00009D04  101A              adc [edx],bl
00009D06  1000              adc [eax],al
00009D08  5A                pop edx
00009D09  0100              add [eax],eax
00009D0B  0012              add [edx],dl
00009D0D  0001              add [ecx],al
00009D0F  000F              add [edi],cl
00009D11  07                pop es
00009D12  0000              add [eax],al
00009D14  4C                dec esp
00009D15  3310              xor edx,[eax]
00009D17  000400            add [eax+eax],al
00009D1A  0000              add [eax],al
00009D1C  1100              adc [eax],eax
00009D1E  0200              add al,[eax]
00009D20  1C07              sbb al,0x7
00009D22  0000              add [eax],al
00009D24  2011              and [ecx],dl
00009D26  1000              adc [eax],al
00009D28  99                cdq
00009D29  0000              add [eax],al
00009D2B  0012              add [edx],dl
00009D2D  0001              add [ecx],al
00009D2F  002407            add [edi+eax],ah
00009D32  0000              add [eax],al
00009D34  D017              rcl byte [edi],1
00009D36  1000              adc [eax],al
00009D38  2800              sub [eax],al
00009D3A  0000              add [eax],al
00009D3C  1200              adc al,[eax]
00009D3E  0100              add [eax],eax
00009D40  3807              cmp [edi],al
00009D42  0000              add [eax],al
00009D44  90                nop
00009D45  1410              adc al,0x10
00009D47  004200            add [edx+0x0],al
00009D4A  0000              add [eax],al
00009D4C  1200              adc al,[eax]
00009D4E  0100              add [eax],eax
00009D50  3F                aas
00009D51  07                pop es
00009D52  0000              add [eax],al
00009D54  D00E              ror byte [esi],1
00009D56  1000              adc [eax],al
00009D58  0F0000            sldt [eax]
00009D5B  0012              add [edx],dl
00009D5D  0001              add [ecx],al
00009D5F  004D07            add [ebp+0x7],cl
00009D62  0000              add [eax],al
00009D64  50                push eax
00009D65  0A10              or dl,[eax]
00009D67  000C00            add [eax+eax],cl
00009D6A  0000              add [eax],al
00009D6C  1200              adc al,[eax]
00009D6E  0100              add [eax],eax
00009D70  5D                pop ebp
00009D71  07                pop es
00009D72  0000              add [eax],al
00009D74  C0                db 0xc0
00009D75  3410              xor al,0x10
00009D77  00FF              add bh,bh
00009D79  0000              add [eax],al
00009D7B  0011              add [ecx],dl
00009D7D  0002              add [edx],al
00009D7F  006607            add [esi+0x7],ah
00009D82  0000              add [eax],al
00009D84  0020              add [eax],ah
00009D86  1000              adc [eax],al
00009D88  640000            add [fs:eax],al
00009D8B  0011              add [ecx],dl
00009D8D  0002              add [edx],al
00009D8F  006C0700          add [edi+eax+0x0],ch
00009D93  0010              add [eax],dl
00009D95  0F1000            movups xmm0,oword [eax]
00009D98  0F0000            sldt [eax]
00009D9B  0012              add [edx],dl
00009D9D  0001              add [ecx],al
00009D9F  007A07            add [edx+0x7],bh
00009DA2  0000              add [eax],al
00009DA4  C0                db 0xc0
00009DA5  3510000400        xor eax,0x40010
00009DAA  0000              add [eax],al
00009DAC  1100              adc [eax],eax
00009DAE  0200              add al,[eax]
00009DB0  8507              test [edi],eax
00009DB2  0000              add [eax],al
00009DB4  A00D100022        mov al,[0x2200100d]
00009DB9  0000              add [eax],al
00009DBB  0012              add [edx],dl
00009DBD  0001              add [ecx],al
00009DBF  0000              add [eax],al
00009DC1  6B65726E          imul esp,[ebp+0x72],byte +0x6e
00009DC5  656C              gs insb
00009DC7  2F                das
00009DC8  6D                insd
00009DC9  756C              jnz 0x9e37
00009DCB  7469              jz 0x9e36
00009DCD  626F6F            bound ebp,[edi+0x6f]
00009DD0  742E              jz 0x9e00
00009DD2  6E                outsb
00009DD3  61                popad
00009DD4  736D              jnc 0x9e43
00009DD6  004D42            add [ebp+0x42],cl
00009DD9  41                inc ecx
00009DDA  4C                dec esp
00009DDB  49                dec ecx
00009DDC  47                inc edi
00009DDD  4E                dec esi
00009DDE  004D45            add [ebp+0x45],cl
00009DE1  4D                dec ebp
00009DE2  49                dec ecx
00009DE3  4E                dec esi
00009DE4  46                inc esi
00009DE5  4F                dec edi
00009DE6  00464C            add [esi+0x4c],al
00009DE9  41                inc ecx
00009DEA  47                inc edi
00009DEB  53                push ebx
00009DEC  004D41            add [ebp+0x41],cl
00009DEF  47                inc edi
00009DF0  49                dec ecx
00009DF1  43                inc ebx
00009DF2  004348            add [ebx+0x48],al
00009DF5  45                inc ebp
00009DF6  43                inc ebx
00009DF7  4B                dec ebx
00009DF8  53                push ebx
00009DF9  55                push ebp
00009DFA  4D                dec ebp
00009DFB  007374            add [ebx+0x74],dh
00009DFE  61                popad
00009DFF  636B5F            arpl [ebx+0x5f],bp
00009E02  626F74            bound ebp,[edi+0x74]
00009E05  746F              jz 0x9e76
00009E07  6D                insd
00009E08  005F73            add [edi+0x73],bl
00009E0B  7461              jz 0x9e6e
00009E0D  7274              jc 0x9e83
00009E0F  2E68616E6700      cs push dword 0x676e61
00009E15  5F                pop edi
00009E16  5F                pop edi
00009E17  6B5F6764          imul ebx,[edi+0x67],byte +0x64
00009E1B  7472              jz 0x9e8f
00009E1D  005F73            add [edi+0x73],bl
00009E20  657447            gs jz 0x9e6a
00009E23  44                inc esp
00009E24  54                push esp
00009E25  5F                pop edi
00009E26  7072              jo 0x9e9a
00009E28  6F                outsd
00009E29  7432              jz 0x9e5d
00009E2B  2E666C            cs o16 insb
00009E2E  7573              jnz 0x9ea3
00009E30  68005F5F6B        push dword 0x6b5f5f00
00009E35  5F                pop edi
00009E36  6964747200746173  imul esp,[esp+esi*2+0x72],dword 0x73617400
00009E3E  6B735F65          imul esi,[ebx+0x5f],byte +0x65
00009E42  6E                outsb
00009E43  64007363          add [fs:ebx+0x63],dh
00009E47  7261              jc 0x9eaa
00009E49  7463              jz 0x9eae
00009E4B  6870747200        push dword 0x727470
00009E50  7363              jnc 0x9eb5
00009E52  7261              jc 0x9eb5
00009E54  7463              jz 0x9eb9
00009E56  6870747232        push dword 0x32727470
00009E5B  005F5F            add [edi+0x5f],bl
00009E5E  696E6974546173    imul ebp,[esi+0x69],dword 0x73615474
00009E65  6B322E            imul esi,[edx],byte +0x2e
00009E68  6E                outsb
00009E69  657874            gs js 0x9ee0
00009E6C  005F5F            add [edi+0x5f],bl
00009E6F  696E6974546173    imul ebp,[esi+0x69],dword 0x73615474
00009E76  6B3233            imul esi,[edx],byte +0x33
00009E79  3400              xor al,0x0
00009E7B  6764742E          fs jz 0x9ead
00009E7F  6300              arpl [eax],ax
00009E81  6B65726E          imul esp,[ebp+0x72],byte +0x6e
00009E85  656C              gs insb
00009E87  5F                pop edi
00009E88  6D                insd
00009E89  61                popad
00009E8A  696E2E63007461    imul ebp,[esi+0x2e],dword 0x61740063
00009E91  736B              jnc 0x9efe
00009E93  2E6300            arpl [cs:eax],ax
00009E96  6D                insd
00009E97  61                popad
00009E98  7374              jnc 0x9f0e
00009E9A  65725F            gs jc 0x9efc
00009E9D  6972715F746162    imul esi,[edx+0x71],dword 0x6261745f
00009EA4  6C                insb
00009EA5  652E6300          arpl [cs:eax],ax
00009EA9  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
00009EB0  7074              jo 0x9f26
00009EB2  5F                pop edi
00009EB3  706F              jo 0x9f24
00009EB5  696E746572732E    imul ebp,[esi+0x74],dword 0x2e737265
00009EBC  6300              arpl [eax],ax
00009EBE  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
00009EC5  7074              jo 0x9f3b
00009EC7  732E              jnc 0x9ef7
00009EC9  6300              arpl [eax],ax
00009ECB  6C                insb
00009ECC  69626B2E630062    imul esp,[edx+0x6b],dword 0x6200632e
00009ED3  7566              jnz 0x9f3b
00009ED5  2E3130            xor [cs:eax],esi
00009ED8  3332              xor esi,[edx]
00009EDA  006275            add [edx+0x75],ah
00009EDD  662E3130          xor [cs:eax],si
00009EE1  3435              xor al,0x35
00009EE3  006275            add [edx+0x75],ah
00009EE6  662E3130          xor [cs:eax],si
00009EEA  3539006865        xor eax,0x65680039
00009EEF  786C              js 0x9f5d
00009EF1  696E6500707269    imul ebp,[esi+0x65],dword 0x69727000
00009EF8  6E                outsb
00009EF9  7466              jz 0x9f61
00009EFB  2E6300            arpl [cs:eax],ax
00009EFE  696F2E63007474    imul ebp,[edi+0x2e],dword 0x74740063
00009F05  792E              jns 0x9f35
00009F07  6300              arpl [eax],ax
00009F09  6B657962          imul esp,[ebp+0x79],byte +0x62
00009F0D  6F                outsd
00009F0E  61                popad
00009F0F  7264              jc 0x9f75
00009F11  2E6300            arpl [cs:eax],ax
00009F14  6B625F71          imul esp,[edx+0x5f],byte +0x71
00009F18  7565              jnz 0x9f7f
00009F1A  7565              jnz 0x9f81
00009F1C  005F69            add [edi+0x69],bl
00009F1F  7372              jnc 0x9f93
00009F21  5F                pop edi
00009F22  68616E646C        push dword 0x6c646e61
00009F27  657239            gs jc 0x9f63
00009F2A  006E65            add [esi+0x65],ch
00009F2D  7874              js 0x9fa3
00009F2F  5F                pop edi
00009F30  7461              jz 0x9f93
00009F32  736B              jnc 0x9f9f
00009F34  006B62            add [ebx+0x62],ch
00009F37  5F                pop edi
00009F38  7175              jno 0x9faf
00009F3A  657565            gs jnz 0x9fa2
00009F3D  5F                pop edi
00009F3E  6200              bound eax,[eax]
00009F40  6973725F32006B    imul esi,[ebx+0x72],dword 0x6b00325f
00009F47  5F                pop edi
00009F48  6465627567        bound esi,[gs:ebp+0x67]
00009F4D  006964            add [ecx+0x64],ch
00009F50  745F              jz 0x9fb1
00009F52  7461              jz 0x9fb5
00009F54  626C655F          bound ebp,[ebp+0x5f]
00009F58  656E              gs outsb
00009F5A  64005F73          add [fs:edi+0x73],bl
00009F5E  657449            gs jz 0x9faa
00009F61  52                push edx
00009F62  54                push esp
00009F63  00746572          add [ebp+0x72],dh
00009F67  6D                insd
00009F68  696E616C5F636F    imul ebp,[esi+0x61],dword 0x6f635f6c
00009F6F  6C                insb
00009F70  6F                outsd
00009F71  7200              jc 0x9f73
00009F73  5F                pop edi
00009F74  6973725F68616E    imul esi,[ebx+0x72],dword 0x6e61685f
00009F7B  646C              fs insb
00009F7D  657231            gs jc 0x9fb1
00009F80  3300              xor eax,[eax]
00009F82  7570              jnz 0x9ff4
00009F84  7065              jo 0x9feb
00009F86  726D              jc 0x9ff5
00009F88  61                popad
00009F89  7000              jo 0x9f8b
00009F8B  5F                pop edi
00009F8C  5F                pop edi
00009F8D  696E6974546173    imul ebp,[esi+0x69],dword 0x73615474
00009F94  6B3200            imul esi,[edx],byte +0x0
00009F97  7461              jz 0x9ffa
00009F99  736B              jnc 0xa006
00009F9B  7300              jnc 0x9f9d
00009F9D  5F                pop edi
00009F9E  5F                pop edi
00009F9F  6B5F6764          imul ebx,[edi+0x67],byte +0x64
00009FA3  7400              jz 0x9fa5
00009FA5  5F                pop edi
00009FA6  6973725F68616E    imul esi,[ebx+0x72],dword 0x6e61685f
00009FAD  646C              fs insb
00009FAF  657232            gs jc 0x9fe4
00009FB2  006973            add [ecx+0x73],ch
00009FB5  725F              jc 0xa016
00009FB7  3800              cmp [eax],al
00009FB9  6973725F310069    imul esi,[ebx+0x72],dword 0x6900315f
00009FC0  7372              jnc 0xa034
00009FC2  5F                pop edi
00009FC3  3500696E74        xor eax,0x746e6900
00009FC8  657272            gs jc 0xa03d
00009FCB  7570              jnz 0xa03d
00009FCD  7473              jz 0xa042
00009FCF  5F                pop edi
00009FD0  696E697469616C    imul ebp,[esi+0x69],dword 0x6c616974
00009FD7  697A6500676574    imul edi,[edx+0x65],dword 0x74656700
00009FDE  636861            arpl [eax+0x61],bp
00009FE1  725F              jc 0xa042
00009FE3  6E                outsb
00009FE4  6F                outsd
00009FE5  7761              ja 0xa048
00009FE7  6974005F6973725F  imul esi,[eax+eax+0x5f],dword 0x5f727369
00009FEF  68616E646C        push dword 0x6c646e61
00009FF4  657236            gs jc 0xa02d
00009FF7  005F69            add [edi+0x69],bl
00009FFA  7372              jnc 0xa06e
00009FFC  5F                pop edi
00009FFD  68616E646C        push dword 0x6c646e61
0000A002  657231            gs jc 0xa036
0000A005  3100              xor [eax],eax
0000A007  6D                insd
0000A008  656D              gs insd
0000A00A  637079            arpl [eax+0x79],si
0000A00D  007265            add [edx+0x65],dh
0000A010  61                popad
0000A011  645F              fs pop edi
0000A013  67647472          fs jz 0xa089
0000A017  00746572          add [ebp+0x72],dh
0000A01B  6D                insd
0000A01C  696E616C5F636C    imul ebp,[esi+0x61],dword 0x6c635f6c
0000A023  6561              gs popad
0000A025  7200              jc 0xa027
0000A027  7465              jz 0xa08e
0000A029  726D              jc 0xa098
0000A02B  696E616C5F7772    imul ebp,[esi+0x61],dword 0x72775f6c
0000A032  697465737472696E  imul esi,[ebp+0x73],dword 0x6e697274
0000A03A  67005F69          add [bx+0x69],bl
0000A03E  7372              jnc 0xa0b2
0000A040  5F                pop edi
0000A041  68616E646C        push dword 0x6c646e61
0000A046  657235            gs jc 0xa07e
0000A049  006973            add [ecx+0x73],ch
0000A04C  6C                insb
0000A04D  6F                outsd
0000A04E  7765              ja 0xa0b5
0000A050  7200              jc 0xa052
0000A052  6B5F746F          imul ebx,[edi+0x74],byte +0x6f
0000A056  7461              jz 0xa0b9
0000A058  6C                insb
0000A059  7461              jz 0xa0bc
0000A05B  736B              jnc 0xa0c8
0000A05D  7300              jnc 0xa05f
0000A05F  746F              jz 0xa0d0
0000A061  6C                insb
0000A062  6F                outsd
0000A063  7765              ja 0xa0ca
0000A065  7200              jc 0xa067
0000A067  6973725F313000    imul esi,[ebx+0x72],dword 0x30315f
0000A06E  6973725F313500    imul esi,[ebx+0x72],dword 0x35315f
0000A075  6B657962          imul esp,[ebp+0x79],byte +0x62
0000A079  6F                outsd
0000A07A  61                popad
0000A07B  7264              jc 0xa0e1
0000A07D  5F                pop edi
0000A07E  706F              jo 0xa0ef
0000A080  6C                insb
0000A081  6C                insb
0000A082  006764            add [edi+0x64],ah
0000A085  745F              jz 0xa0e6
0000A087  656E              gs outsb
0000A089  636F64            arpl [edi+0x64],bp
0000A08C  65006973          add [gs:ecx+0x73],ch
0000A090  725F              jc 0xa0f1
0000A092  3132              xor [edx],esi
0000A094  007265            add [edx+0x65],dh
0000A097  61                popad
0000A098  645F              fs pop edi
0000A09A  6C                insb
0000A09B  6964740073637261  imul esp,[esp+esi*2+0x0],dword 0x61726373
0000A0A3  7463              jz 0xa108
0000A0A5  6870747233        push dword 0x33727470
0000A0AA  006973            add [ecx+0x73],ch
0000A0AD  725F              jc 0xa10e
0000A0AF  3000              xor [eax],al
0000A0B1  7461              jz 0xa114
0000A0B3  736B              jnc 0xa120
0000A0B5  7374              jnc 0xa12b
0000A0B7  61                popad
0000A0B8  636B73            arpl [ebx+0x73],bp
0000A0BB  006764            add [edi+0x64],ah
0000A0BE  745F              jz 0xa11f
0000A0C0  656E              gs outsb
0000A0C2  636F64            arpl [edi+0x64],bp
0000A0C5  653200            xor al,[gs:eax]
0000A0C8  6B65726E          imul esp,[ebp+0x72],byte +0x6e
0000A0CC  656C              gs insb
0000A0CE  5F                pop edi
0000A0CF  7461              jz 0xa132
0000A0D1  736B              jnc 0xa13e
0000A0D3  3100              xor [eax],eax
0000A0D5  5F                pop edi
0000A0D6  7365              jnc 0xa13d
0000A0D8  7447              jz 0xa121
0000A0DA  44                inc esp
0000A0DB  54                push esp
0000A0DC  5F                pop edi
0000A0DD  7072              jo 0xa151
0000A0DF  6F                outsd
0000A0E0  7432              jz 0xa114
0000A0E2  006D61            add [ebp+0x61],ch
0000A0E5  6B655F76          imul esp,[ebp+0x5f],byte +0x76
0000A0E9  6761              a16 popad
0000A0EB  656E              gs outsb
0000A0ED  7472              jz 0xa161
0000A0EF  7900              jns 0xa0f1
0000A0F1  5F                pop edi
0000A0F2  67657463          gs jz 0xa159
0000A0F6  6861725F6C        push dword 0x6c5f7261
0000A0FB  61                popad
0000A0FC  7374              jnc 0xa172
0000A0FE  5F                pop edi
0000A0FF  6300              arpl [eax],ax
0000A101  5F                pop edi
0000A102  5F                pop edi
0000A103  7377              jnc 0xa17c
0000A105  697463685461736B  imul esi,[ebx+0x68],dword 0x6b736154
0000A10D  005049            add [eax+0x49],dl
0000A110  43                inc ebx
0000A111  5F                pop edi
0000A112  7265              jc 0xa179
0000A114  6D                insd
0000A115  61                popad
0000A116  7000              jo 0xa118
0000A118  6B707574          imul esi,[eax+0x75],byte +0x74
0000A11C  7569              jnz 0xa187
0000A11E  6E                outsb
0000A11F  7400              jz 0xa121
0000A121  6973725F33005F    imul esi,[ebx+0x72],dword 0x5f00335f
0000A128  5F                pop edi
0000A129  696E69744D6169    imul ebp,[esi+0x69],dword 0x69614d74
0000A130  6E                outsb
0000A131  54                push esp
0000A132  61                popad
0000A133  736B              jnc 0xa1a0
0000A135  00746572          add [ebp+0x72],dh
0000A139  6D                insd
0000A13A  696E616C5F7075    imul ebp,[esi+0x61],dword 0x75705f6c
0000A141  7463              jz 0xa1a6
0000A143  686172006B        push dword 0x6b007261
0000A148  65726E            gs jc 0xa1b9
0000A14B  656C              gs insb
0000A14D  5F                pop edi
0000A14E  6D                insd
0000A14F  61                popad
0000A150  696E006B65726E    imul ebp,[esi+0x0],dword 0x6e72656b
0000A157  656C              gs insb
0000A159  5F                pop edi
0000A15A  7461              jz 0xa1bd
0000A15C  736B              jnc 0xa1c9
0000A15E  3200              xor al,[eax]
0000A160  7374              jnc 0xa1d6
0000A162  61                popad
0000A163  7274              jc 0xa1d9
0000A165  7570              jnz 0xa1d7
0000A167  5F                pop edi
0000A168  6B65726E          imul esp,[ebp+0x72],byte +0x6e
0000A16C  656C              gs insb
0000A16E  005F5F            add [edi+0x5f],bl
0000A171  6B5F6764          imul ebx,[edi+0x67],byte +0x64
0000A175  745F              jz 0xa1d6
0000A177  656E              gs outsb
0000A179  64006B5F          add [fs:ebx+0x5f],ch
0000A17D  6C                insb
0000A17E  61                popad
0000A17F  7374              jnc 0xa1f5
0000A181  7461              jz 0xa1e4
0000A183  736B              jnc 0xa1f0
0000A185  7000              jo 0xa187
0000A187  6C                insb
0000A188  61                popad
0000A189  7374              jnc 0xa1ff
0000A18B  5F                pop edi
0000A18C  697271005F6973    imul esi,[edx+0x71],dword 0x73695f00
0000A193  725F              jc 0xa1f4
0000A195  68616E646C        push dword 0x6c646e61
0000A19A  657234            gs jc 0xa1d1
0000A19D  005049            add [eax+0x49],dl
0000A1A0  43                inc ebx
0000A1A1  5F                pop edi
0000A1A2  6765745F          gs jz 0xa205
0000A1A6  697372005F6973    imul esi,[ebx+0x72],dword 0x73695f00
0000A1AD  725F              jc 0xa20e
0000A1AF  68616E646C        push dword 0x6c646e61
0000A1B4  657230            gs jc 0xa1e7
0000A1B7  006B62            add [ebx+0x62],ch
0000A1BA  5F                pop edi
0000A1BB  6D                insd
0000A1BC  795F              jns 0xa21d
0000A1BE  69737072696E74    imul esi,[ebx+0x70],dword 0x746e6972
0000A1C5  00746572          add [ebp+0x72],dh
0000A1C9  6D                insd
0000A1CA  696E616C5F7365    imul ebp,[esi+0x61],dword 0x65735f6c
0000A1D1  7463              jz 0xa236
0000A1D3  6F                outsd
0000A1D4  6C                insb
0000A1D5  6F                outsd
0000A1D6  7200              jc 0xa1d8
0000A1D8  7461              jz 0xa23b
0000A1DA  736B              jnc 0xa247
0000A1DC  735F              jnc 0xa23d
0000A1DE  696E697469616C    imul ebp,[esi+0x69],dword 0x6c616974
0000A1E5  697A6500746572    imul edi,[edx+0x65],dword 0x72657400
0000A1EC  6D                insd
0000A1ED  696E616C5F696E    imul ebp,[esi+0x61],dword 0x6e695f6c
0000A1F4  697469616C697A65  imul esi,[ecx+ebp*2+0x61],dword 0x657a696c
0000A1FC  006B70            add [ebx+0x70],ch
0000A1FF  7574              jnz 0xa275
0000A201  7568              jnz 0xa26b
0000A203  657800            gs js 0xa206
0000A206  6D                insd
0000A207  61                popad
0000A208  6B655F63          imul esp,[ebp+0x5f],byte +0x63
0000A20C  6F                outsd
0000A20D  6C                insb
0000A20E  6F                outsd
0000A20F  7200              jc 0xa211
0000A211  5F                pop edi
0000A212  7374              jnc 0xa288
0000A214  61                popad
0000A215  7274              jc 0xa28b
0000A217  005F69            add [edi+0x69],bl
0000A21A  7372              jnc 0xa28e
0000A21C  5F                pop edi
0000A21D  68616E646C        push dword 0x6c646e61
0000A222  657231            gs jc 0xa256
0000A225  3200              xor al,[eax]
0000A227  6B5F6375          imul ebx,[edi+0x63],byte +0x75
0000A22B  7274              jc 0xa2a1
0000A22D  61                popad
0000A22E  736B              jnc 0xa29b
0000A230  7000              jo 0xa232
0000A232  6973725F313300    imul esi,[ebx+0x72],dword 0x33315f
0000A239  69737570706572    imul esi,[ebx+0x75],dword 0x72657070
0000A240  006B5F            add [ebx+0x5f],ch
0000A243  7069              jo 0xa2ae
0000A245  64626173          bound esp,[fs:ecx+0x73]
0000A249  6500746572        add [gs:ebp+0x72],dh
0000A24E  6D                insd
0000A24F  696E616C5F636F    imul ebp,[esi+0x61],dword 0x6f635f6c
0000A256  6C                insb
0000A257  756D              jnz 0xa2c6
0000A259  6E                outsb
0000A25A  006E6F            add [esi+0x6f],ch
0000A25D  705F              jo 0xa2be
0000A25F  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
0000A266  7074              jo 0xa2dc
0000A268  5F                pop edi
0000A269  68616E646C        push dword 0x6c646e61
0000A26E  657200            gs jc 0xa271
0000A271  6973725F370073    imul esi,[ebx+0x72],dword 0x7300375f
0000A278  7461              jz 0xa2db
0000A27A  636B5F            arpl [ebx+0x5f],bp
0000A27D  746F              jz 0xa2ee
0000A27F  7000              jo 0xa281
0000A281  6973725F34006B    imul esi,[ebx+0x72],dword 0x6b00345f
0000A288  625F71            bound ebx,[edi+0x71]
0000A28B  7565              jnz 0xa2f2
0000A28D  7565              jnz 0xa2f4
0000A28F  5F                pop edi
0000A290  61                popad
0000A291  006C6962          add [ecx+ebp*2+0x62],ch
0000A295  6B5F696E          imul ebx,[edi+0x69],byte +0x6e
0000A299  697469616C697A65  imul esi,[ecx+ebp*2+0x61],dword 0x657a696c
0000A2A1  0074696D          add [ecx+ebp*2+0x6d],dh
0000A2A5  65725F            gs jc 0xa307
0000A2A8  696E697469616C    imul ebp,[esi+0x69],dword 0x6c616974
0000A2AF  697A6500504943    imul edi,[edx+0x65],dword 0x43495000
0000A2B6  5F                pop edi
0000A2B7  6765745F          gs jz 0xa31a
0000A2BB  697272006B625F    imul esi,[edx+0x72],dword 0x5f626b00
0000A2C2  6D                insd
0000A2C3  6F                outsd
0000A2C4  64666C            fs o16 insb
0000A2C7  61                popad
0000A2C8  6700696E          add [bx+di+0x6e],ch
0000A2CC  7465              jz 0xa333
0000A2CE  7272              jc 0xa342
0000A2D0  7570              jnz 0xa342
0000A2D2  7473              jz 0xa347
0000A2D4  5F                pop edi
0000A2D5  61                popad
0000A2D6  64645F            fs pop edi
0000A2D9  68616E646C        push dword 0x6c646e61
0000A2DE  657200            gs jc 0xa2e1
0000A2E1  667265            o16 jc 0xa349
0000A2E4  655F              gs pop edi
0000A2E6  7374              jnc 0xa35c
0000A2E8  61                popad
0000A2E9  636B00            arpl [ebx+0x0],bp
0000A2EC  6D                insd
0000A2ED  656D              gs insd
0000A2EF  7365              jnc 0xa356
0000A2F1  7400              jz 0xa2f3
0000A2F3  7363              jnc 0xa358
0000A2F5  61                popad
0000A2F6  6E                outsb
0000A2F7  636F64            arpl [edi+0x64],bp
0000A2FA  655F              gs pop edi
0000A2FC  7365              jnc 0xa363
0000A2FE  7432              jz 0xa332
0000A300  005F69            add [edi+0x69],bl
0000A303  7372              jnc 0xa377
0000A305  5F                pop edi
0000A306  68616E646C        push dword 0x6c646e61
0000A30B  657231            gs jc 0xa33f
0000A30E  3000              xor [eax],al
0000A310  6B657962          imul esp,[ebp+0x79],byte +0x62
0000A314  6F                outsd
0000A315  61                popad
0000A316  7264              jc 0xa37c
0000A318  5F                pop edi
0000A319  6765745F          gs jz 0xa37c
0000A31D  6D                insd
0000A31E  6F                outsd
0000A31F  64666C            fs o16 insb
0000A322  61                popad
0000A323  67006C6F          add [si+0x6f],ch
0000A327  7765              ja 0xa38e
0000A329  726D              jc 0xa398
0000A32B  61                popad
0000A32C  7000              jo 0xa32e
0000A32E  67657463          gs jz 0xa395
0000A332  686172005F        push dword 0x5f007261
0000A337  64697361626C655F  imul esi,[fs:ebx+0x61],dword 0x5f656c62
0000A33F  50                push eax
0000A340  49                dec ecx
0000A341  43                inc ebx
0000A342  006973            add [ecx+0x73],ch
0000A345  725F              jc 0xa3a6
0000A347  656E              gs outsb
0000A349  6400746572        add [fs:ebp+0x72],dh
0000A34E  6D                insd
0000A34F  696E616C5F726F    imul ebp,[esi+0x61],dword 0x6f725f6c
0000A356  7770              ja 0xa3c8
0000A358  7573              jnz 0xa3cd
0000A35A  6800697271        push dword 0x71726900
0000A35F  5F                pop edi
0000A360  6B62005F          imul esp,[edx+0x0],byte +0x5f
0000A364  6973725F68616E    imul esi,[ebx+0x72],dword 0x6e61685f
0000A36B  646C              fs insb
0000A36D  657231            gs jc 0xa3a1
0000A370  3500697370        xor eax,0x70736900
0000A375  7269              jc 0xa3e0
0000A377  6E                outsb
0000A378  7400              jz 0xa37a
0000A37A  7370              jnc 0xa3ec
0000A37C  61                popad
0000A37D  776E              ja 0xa3ed
0000A37F  5F                pop edi
0000A380  7461              jz 0xa3e3
0000A382  736B              jnc 0xa3ef
0000A384  007365            add [ebx+0x65],dh
0000A387  745F              jz 0xa3e8
0000A389  6B5F6375          imul ebx,[edi+0x63],byte +0x75
0000A38D  7274              jc 0xa403
0000A38F  61                popad
0000A390  736B              jnc 0xa3fd
0000A392  7000              jo 0xa394
0000A394  6764745F          fs jz 0xa3f7
0000A398  6465636F64        arpl [gs:edi+0x64],bp
0000A39D  65007265          add [gs:edx+0x65],dh
0000A3A1  61                popad
0000A3A2  645F              fs pop edi
0000A3A4  65666C            gs o16 insb
0000A3A7  61                popad
0000A3A8  677300            jnc 0xa3ab
0000A3AB  5F                pop edi
0000A3AC  5F                pop edi
0000A3AD  7377              jnc 0xa426
0000A3AF  6974636842007465  imul esi,[ebx+0x68],dword 0x65740042
0000A3B7  726D              jc 0xa426
0000A3B9  696E616C5F6275    imul ebp,[esi+0x61],dword 0x75625f6c
0000A3C0  6666657200        gs o16 jc 0xa3c5
0000A3C5  5F                pop edi
0000A3C6  6973725F68616E    imul esi,[ebx+0x72],dword 0x6e61685f
0000A3CD  646C              fs insb
0000A3CF  657231            gs jc 0xa403
0000A3D2  3400              xor al,0x0
0000A3D4  746F              jz 0xa445
0000A3D6  745F              jz 0xa437
0000A3D8  6964747074727300  imul esp,[esp+esi*2+0x70],dword 0x737274
0000A3E0  7461              jz 0xa443
0000A3E2  736B              jnc 0xa44f
0000A3E4  5F                pop edi
0000A3E5  7377              jnc 0xa45e
0000A3E7  69746368006B6579  imul esi,[ebx+0x68],dword 0x79656b00
0000A3EF  626F61            bound ebp,[edi+0x61]
0000A3F2  7264              jc 0xa458
0000A3F4  5F                pop edi
0000A3F5  696E697469616C    imul ebp,[esi+0x69],dword 0x6c616974
0000A3FC  697A6500495251    imul edi,[edx+0x65],dword 0x51524900
0000A403  5F                pop edi
0000A404  636C6561          arpl [ebp+0x61],bp
0000A408  725F              jc 0xa469
0000A40A  6D                insd
0000A40B  61                popad
0000A40C  736B              jnc 0xa479
0000A40E  006973            add [ecx+0x73],ch
0000A411  725F              jc 0xa472
0000A413  3900              cmp [eax],eax
0000A415  6B65726E          imul esp,[ebp+0x72],byte +0x6e
0000A419  656C              gs insb
0000A41B  5F                pop edi
0000A41C  7469              jz 0xa487
0000A41E  636B00            arpl [ebx+0x0],bp
0000A421  637572            arpl [ebp+0x72],si
0000A424  5F                pop edi
0000A425  7461              jz 0xa488
0000A427  736B              jnc 0xa494
0000A429  006D61            add [ebp+0x61],ch
0000A42C  7374              jnc 0xa4a2
0000A42E  65725F            gs jc 0xa490
0000A431  696E7465727275    imul ebp,[esi+0x74],dword 0x75727265
0000A438  7074              jo 0xa4ae
0000A43A  5F                pop edi
0000A43B  7461              jz 0xa49e
0000A43D  626C6500          bound ebp,[ebp+0x0]
0000A441  6B707269          imul esi,[eax+0x72],byte +0x69
0000A445  6E                outsb
0000A446  7466              jz 0xa4ae
0000A448  006764            add [edi+0x64],ah
0000A44B  745F              jz 0xa4ac
0000A44D  696E697469616C    imul ebp,[esi+0x69],dword 0x6c616974
0000A454  697A6500646973    imul edi,[edx+0x65],dword 0x73696400
0000A45B  61                popad
0000A45C  626C655F          bound ebp,[ebp+0x5f]
0000A460  50                push eax
0000A461  49                dec ecx
0000A462  43                inc ebx
0000A463  005F69            add [edi+0x69],bl
0000A466  7372              jnc 0xa4da
0000A468  5F                pop edi
0000A469  68616E646C        push dword 0x6c646e61
0000A46E  657238            gs jc 0xa4a9
0000A471  006973            add [ecx+0x73],ch
0000A474  725F              jc 0xa4d5
0000A476  3600696E          add [ss:ecx+0x6e],ch
0000A47A  7465              jz 0xa4e1
0000A47C  7272              jc 0xa4f0
0000A47E  7570              jnz 0xa4f0
0000A480  7473              jz 0xa4f5
0000A482  5F                pop edi
0000A483  7265              jc 0xa4ea
0000A485  6D                insd
0000A486  6F                outsd
0000A487  7665              jna 0xa4ee
0000A489  5F                pop edi
0000A48A  68616E646C        push dword 0x6c646e61
0000A48F  657200            gs jc 0xa492
0000A492  6964747074727300  imul esp,[esp+esi*2+0x70],dword 0x737274
0000A49A  6973725F313100    imul esi,[ebx+0x72],dword 0x31315f
0000A4A1  6964745F7461626C  imul esp,[esp+esi*2+0x5f],dword 0x6c626174
0000A4A9  65006973          add [gs:ecx+0x73],ch
0000A4AD  725F              jc 0xa50e
0000A4AF  313400            xor [eax+eax],esi
0000A4B2  7374              jnc 0xa528
0000A4B4  726C              jc 0xa522
0000A4B6  656E              gs outsb
0000A4B8  00746F75          add [edi+ebp*2+0x75],dh
0000A4BC  7070              jo 0xa52e
0000A4BE  657200            gs jc 0xa4c1
0000A4C1  5F                pop edi
0000A4C2  6973725F68616E    imul esi,[ebx+0x72],dword 0x6e61685f
0000A4C9  646C              fs insb
0000A4CB  657231            gs jc 0xa4ff
0000A4CE  00746572          add [ebp+0x72],dh
0000A4D2  6D                insd
0000A4D3  696E616C5F726F    imul ebp,[esi+0x61],dword 0x6f725f6c
0000A4DA  7700              ja 0xa4dc
0000A4DC  6B707574          imul esi,[eax+0x75],byte +0x74
0000A4E0  696E7400746572    imul ebp,[esi+0x74],dword 0x72657400
0000A4E7  6D                insd
0000A4E8  696E616C5F7075    imul ebp,[esi+0x61],dword 0x75705f6c
0000A4EF  7465              jz 0xa556
0000A4F1  6E                outsb
0000A4F2  7472              jz 0xa566
0000A4F4  7961              jns 0xa557
0000A4F6  7400              jz 0xa4f8
0000A4F8  6B657272          imul esp,[ebp+0x72],byte +0x72
0000A4FC  6F                outsd
0000A4FD  7200              jc 0xa4ff
0000A4FF  5F                pop edi
0000A500  6973725F68616E    imul esi,[ebx+0x72],dword 0x6e61685f
0000A507  646C              fs insb
0000A509  657233            gs jc 0xa53f
0000A50C  006B65            add [ebx+0x65],ch
0000A50F  726E              jc 0xa57f
0000A511  656C              gs insb
0000A513  5F                pop edi
0000A514  7465              jz 0xa57b
0000A516  7374              jnc 0xa58c
0000A518  63616C            arpl [ecx+0x6c],sp
0000A51B  6C                insb
0000A51C  006B65            add [ebx+0x65],ch
0000A51F  7970              jns 0xa591
0000A521  7265              jc 0xa588
0000A523  7373              jnc 0xa598
0000A525  006D79            add [ebp+0x79],ch
0000A528  54                push esp
0000A529  7373              jnc 0xa59e
0000A52B  005F69            add [edi+0x69],bl
0000A52E  7372              jnc 0xa5a2
0000A530  5F                pop edi
0000A531  68616E646C        push dword 0x6c646e61
0000A536  657237            gs jc 0xa570
0000A539  006B62            add [ebx+0x62],ch
0000A53C  5F                pop edi
0000A53D  746F              jz 0xa5ae
0000A53F  67676C            a16 insb
0000A542  657300            gs jnc 0xa545
0000A545  49                dec ecx
0000A546  52                push edx
0000A547  51                push ecx
0000A548  5F                pop edi
0000A549  7365              jnc 0xa5b0
0000A54B  745F              jz 0xa5ac
0000A54D  6D                insd
0000A54E  61                popad
0000A54F  736B              jnc 0xa5bc
0000A551  0000              add [eax],al
0000A553  0000              add [eax],al
0000A555  0000              add [eax],al
0000A557  0000              add [eax],al
0000A559  0000              add [eax],al
0000A55B  0000              add [eax],al
0000A55D  0000              add [eax],al
0000A55F  0000              add [eax],al
0000A561  0000              add [eax],al
0000A563  0000              add [eax],al
0000A565  0000              add [eax],al
0000A567  0000              add [eax],al
0000A569  0000              add [eax],al
0000A56B  0000              add [eax],al
0000A56D  0000              add [eax],al
0000A56F  0000              add [eax],al
0000A571  0000              add [eax],al
0000A573  0000              add [eax],al
0000A575  0000              add [eax],al
0000A577  0000              add [eax],al
0000A579  0000              add [eax],al
0000A57B  001B              add [ebx],bl
0000A57D  0000              add [eax],al
0000A57F  0001              add [ecx],al
0000A581  0000              add [eax],al
0000A583  0006              add [esi],al
0000A585  0000              add [eax],al
0000A587  0000              add [eax],al
0000A589  0010              add [eax],dl
0000A58B  0000              add [eax],al
0000A58D  1000              adc [eax],al
0000A58F  000F              add [edi],cl
0000A591  1E                push ds
0000A592  0000              add [eax],al
0000A594  0000              add [eax],al
0000A596  0000              add [eax],al
0000A598  0000              add [eax],al
0000A59A  0000              add [eax],al
0000A59C  0010              add [eax],dl
0000A59E  0000              add [eax],al
0000A5A0  0000              add [eax],al
0000A5A2  0000              add [eax],al
0000A5A4  2100              and [eax],eax
0000A5A6  0000              add [eax],al
0000A5A8  0800              or [eax],al
0000A5AA  0000              add [eax],al
0000A5AC  0300              add eax,[eax]
0000A5AE  0000              add [eax],al
0000A5B0  0020              add [eax],ah
0000A5B2  1000              adc [eax],al
0000A5B4  0030              add [eax],dh
0000A5B6  0000              add [eax],al
0000A5B8  40                inc eax
0000A5B9  1A00              sbb al,[eax]
0000A5BB  0000              add [eax],al
0000A5BD  0000              add [eax],al
0000A5BF  0000              add [eax],al
0000A5C1  0000              add [eax],al
0000A5C3  0000              add [eax],al
0000A5C5  1000              adc [eax],al
0000A5C7  0000              add [eax],al
0000A5C9  0000              add [eax],al
0000A5CB  0026              add [esi],ah
0000A5CD  0000              add [eax],al
0000A5CF  0008              add [eax],cl
0000A5D1  0000              add [eax],al
0000A5D3  0002              add [edx],al
0000A5D5  0000              add [eax],al
0000A5D7  00403A            add [eax+0x3a],al
0000A5DA  1000              adc [eax],al
0000A5DC  0030              add [eax],dh
0000A5DE  0000              add [eax],al
0000A5E0  3000              xor [eax],al
0000A5E2  0000              add [eax],al
0000A5E4  0000              add [eax],al
0000A5E6  0000              add [eax],al
0000A5E8  0000              add [eax],al
0000A5EA  0000              add [eax],al
0000A5EC  0800              or [eax],al
0000A5EE  0000              add [eax],al
0000A5F0  0000              add [eax],al
0000A5F2  0000              add [eax],al
0000A5F4  2C00              sub al,0x0
0000A5F6  0000              add [eax],al
0000A5F8  0800              or [eax],al
0000A5FA  0000              add [eax],al
0000A5FC  0200              add al,[eax]
0000A5FE  0000              add [eax],al
0000A600  703A              jo 0xa63c
0000A602  1000              adc [eax],al
0000A604  0030              add [eax],dh
0000A606  0000              add [eax],al
0000A608  004000            add [eax+0x0],al
0000A60B  0000              add [eax],al
0000A60D  0000              add [eax],al
0000A60F  0000              add [eax],al
0000A611  0000              add [eax],al
0000A613  000400            add [eax+eax],al
0000A616  0000              add [eax],al
0000A618  0000              add [eax],al
0000A61A  0000              add [eax],al
0000A61C  3E0000            add [ds:eax],al
0000A61F  0008              add [eax],cl
0000A621  0000              add [eax],al
0000A623  0002              add [edx],al
0000A625  0000              add [eax],al
0000A627  00707A            add [eax+0x7a],dh
0000A62A  1000              adc [eax],al
0000A62C  0030              add [eax],dh
0000A62E  0000              add [eax],al
0000A630  0008              add [eax],cl
0000A632  0000              add [eax],al
0000A634  0000              add [eax],al
0000A636  0000              add [eax],al
0000A638  0000              add [eax],al
0000A63A  0000              add [eax],al
0000A63C  0800              or [eax],al
0000A63E  0000              add [eax],al
0000A640  0000              add [eax],al
0000A642  0000              add [eax],al
0000A644  4A                dec edx
0000A645  0000              add [eax],al
0000A647  0001              add [ecx],al
0000A649  0000              add [eax],al
0000A64B  0003              add [ebx],al
0000A64D  0000              add [eax],al
0000A64F  0000              add [eax],al
0000A651  90                nop
0000A652  1000              adc [eax],al
0000A654  0030              add [eax],dh
0000A656  0000              add [eax],al
0000A658  C0420000          rol byte [edx+0x0],byte 0x0
0000A65C  0000              add [eax],al
0000A65E  0000              add [eax],al
0000A660  0000              add [eax],al
0000A662  0000              add [eax],al
0000A664  0010              add [eax],dl
0000A666  0000              add [eax],al
0000A668  0000              add [eax],al
0000A66A  0000              add [eax],al
0000A66C  50                push eax
0000A66D  0000              add [eax],al
0000A66F  0001              add [ecx],al
0000A671  0000              add [eax],al
0000A673  0002              add [edx],al
0000A675  0000              add [eax],al
0000A677  0000              add [eax],al
0000A679  E010              loopne 0xa68b
0000A67B  0000              add [eax],al
0000A67D  800000            add byte [eax],0x0
0000A680  640100            add [fs:eax],eax
0000A683  0000              add [eax],al
0000A685  0000              add [eax],al
0000A687  0000              add [eax],al
0000A689  0000              add [eax],al
0000A68B  0000              add [eax],al
0000A68D  1000              adc [eax],al
0000A68F  0000              add [eax],al
0000A691  0000              add [eax],al
0000A693  005800            add [eax+0x0],bl
0000A696  0000              add [eax],al
0000A698  0100              add [eax],eax
0000A69A  0000              add [eax],al
0000A69C  3200              xor al,[eax]
0000A69E  0000              add [eax],al
0000A6A0  64E110            fs loope 0xa6b3
0000A6A3  00648100          add [ecx+eax*4+0x0],ah
0000A6A7  002402            add [edx+eax],ah
0000A6AA  0000              add [eax],al
0000A6AC  0000              add [eax],al
0000A6AE  0000              add [eax],al
0000A6B0  0000              add [eax],al
0000A6B2  0000              add [eax],al
0000A6B4  0100              add [eax],eax
0000A6B6  0000              add [eax],al
0000A6B8  0100              add [eax],eax
0000A6BA  0000              add [eax],al
0000A6BC  670000            add [bx+si],al
0000A6BF  0001              add [ecx],al
0000A6C1  0000              add [eax],al
0000A6C3  0002              add [edx],al
0000A6C5  0000              add [eax],al
0000A6C7  0088E3100088      add [eax-0x77ffef1d],cl
0000A6CD  830000            add dword [eax],byte +0x0
0000A6D0  640C00            fs or al,0x0
0000A6D3  0000              add [eax],al
0000A6D5  0000              add [eax],al
0000A6D7  0000              add [eax],al
0000A6D9  0000              add [eax],al
0000A6DB  000400            add [eax+eax],al
0000A6DE  0000              add [eax],al
0000A6E0  0000              add [eax],al
0000A6E2  0000              add [eax],al
0000A6E4  7100              jno 0xa6e6
0000A6E6  0000              add [eax],al
0000A6E8  0100              add [eax],eax
0000A6EA  0000              add [eax],al
0000A6EC  3200              xor al,[eax]
0000A6EE  0000              add [eax],al
0000A6F0  EC                in al,dx
0000A6F1  EF                out dx,eax
0000A6F2  1000              adc [eax],al
0000A6F4  EC                in al,dx
0000A6F5  8F00              pop dword [eax]
0000A6F7  0028              add [eax],ch
0000A6F9  0200              add al,[eax]
0000A6FB  0000              add [eax],al
0000A6FD  0000              add [eax],al
0000A6FF  0000              add [eax],al
0000A701  0000              add [eax],al
0000A703  000400            add [eax+eax],al
0000A706  0000              add [eax],al
0000A708  0100              add [eax],eax
0000A70A  0000              add [eax],al
0000A70C  800000            add byte [eax],0x0
0000A70F  0001              add [ecx],al
0000A711  0000              add [eax],al
0000A713  0030              add [eax],dh
0000A715  0000              add [eax],al
0000A717  0000              add [eax],al
0000A719  0000              add [eax],al
0000A71B  001492            add [edx+edx*4],dl
0000A71E  0000              add [eax],al
0000A720  1100              adc [eax],eax
0000A722  0000              add [eax],al
0000A724  0000              add [eax],al
0000A726  0000              add [eax],al
0000A728  0000              add [eax],al
0000A72A  0000              add [eax],al
0000A72C  0100              add [eax],eax
0000A72E  0000              add [eax],al
0000A730  0100              add [eax],eax
0000A732  0000              add [eax],al
0000A734  1100              adc [eax],eax
0000A736  0000              add [eax],al
0000A738  0300              add eax,[eax]
0000A73A  0000              add [eax],al
0000A73C  0000              add [eax],al
0000A73E  0000              add [eax],al
0000A740  0000              add [eax],al
0000A742  0000              add [eax],al
0000A744  2592000089        and eax,0x89000092
0000A749  0000              add [eax],al
0000A74B  0000              add [eax],al
0000A74D  0000              add [eax],al
0000A74F  0000              add [eax],al
0000A751  0000              add [eax],al
0000A753  0001              add [ecx],al
0000A755  0000              add [eax],al
0000A757  0000              add [eax],al
0000A759  0000              add [eax],al
0000A75B  0001              add [ecx],al
0000A75D  0000              add [eax],al
0000A75F  0002              add [edx],al
0000A761  0000              add [eax],al
0000A763  0000              add [eax],al
0000A765  0000              add [eax],al
0000A767  0000              add [eax],al
0000A769  0000              add [eax],al
0000A76B  00B092000010      add [eax+0x10000092],dh
0000A771  0B00              or eax,[eax]
0000A773  000E              add [esi],cl
0000A775  0000              add [eax],al
0000A777  002C00            add [eax+eax],ch
0000A77A  0000              add [eax],al
0000A77C  0400              add al,0x0
0000A77E  0000              add [eax],al
0000A780  1000              adc [eax],al
0000A782  0000              add [eax],al
0000A784  0900              or [eax],eax
0000A786  0000              add [eax],al
0000A788  0300              add eax,[eax]
0000A78A  0000              add [eax],al
0000A78C  0000              add [eax],al
0000A78E  0000              add [eax],al
0000A790  0000              add [eax],al
0000A792  0000              add [eax],al
0000A794  C09D0000920700    rcr byte [ebp+0x7920000],byte 0x0
0000A79B  0000              add [eax],al
0000A79D  0000              add [eax],al
0000A79F  0000              add [eax],al
0000A7A1  0000              add [eax],al
0000A7A3  0001              add [ecx],al
0000A7A5  0000              add [eax],al
0000A7A7  0000              add [eax],al
0000A7A9  0000              add [eax],al
0000A7AB  00                db 0x00
