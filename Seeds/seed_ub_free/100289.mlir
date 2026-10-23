#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
#map2 = affine_map<() -> ()>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-117> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<-72> : tensor<i32>}> : () -> tensor<i32>
    cf.br ^bb1(%0 : tensor<10xi32>)
  ^bb1(%2: tensor<10xi32>):  // 2 preds: ^bb0, ^bb2
    %3 = tensor.empty() : tensor<i32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction"]} ins(%2 : tensor<10xi32>) outs(%3 : tensor<i32>) {
    ^bb0(%in: i32, %out: i32):
      %11 = arith.addi %out, %in : i32
      linalg.yield %11 : i32
    } -> tensor<i32>
    %5 = tensor.empty() : tensor<i1>
    %6 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%4, %1 : tensor<i32>, tensor<i32>) outs(%5 : tensor<i1>) {
    ^bb0(%in: i32, %in_0: i32, %out: i1):
      %11 = arith.cmpi slt, %in, %in_0 : i32
      linalg.yield %11 : i1
    } -> tensor<i1>
    %extracted = tensor.extract %6[] : tensor<i1>
    cf.cond_br %extracted, ^bb2(%4 : tensor<i32>), ^bb3(%4 : tensor<i32>)
  ^bb2(%7: tensor<i32>):  // pred: ^bb1
    %8 = tensor.empty() : tensor<10xi32>
    %9 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel"]} ins(%7 : tensor<i32>) outs(%8 : tensor<10xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    } -> tensor<10xi32>
    cf.br ^bb1(%9 : tensor<10xi32>)
  ^bb3(%10: tensor<i32>):  // pred: ^bb1
    %cast = tensor.cast %10 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

