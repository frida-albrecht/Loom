#map = affine_map<() -> ()>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %c0_i32 = arith.constant 0 : i32
    %from_elements = tensor.from_elements %c0_i32 : tensor<i32>
    %c10_i32 = arith.constant 10 : i32
    %from_elements_0 = tensor.from_elements %c10_i32 : tensor<i32>
    cf.br ^bb1(%from_elements : tensor<i32>)
  ^bb1(%0: tensor<i32>):  // pred: ^bb0
    %1 = tensor.empty() : tensor<i1>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%0, %from_elements_0 : tensor<i32>, tensor<i32>) outs(%1 : tensor<i1>) {
    ^bb0(%in: i32, %in_2: i32, %out: i1):
      %7 = arith.cmpi slt, %in, %in_2 : i32
      linalg.yield %7 : i1
    } -> tensor<i1>
    %extracted = tensor.extract %2[] : tensor<i1>
    cf.cond_br %extracted, ^bb2(%0 : tensor<i32>), ^bb2(%0 : tensor<i32>)
  ^bb2(%3: tensor<i32>):  // 2 preds: ^bb1, ^bb1
    %from_elements_1 = tensor.from_elements %c10_i32 : tensor<i32>
    %4 = tensor.empty() : tensor<i32>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%3, %from_elements_1 : tensor<i32>, tensor<i32>) outs(%4 : tensor<i32>) {
    ^bb0(%in: i32, %in_2: i32, %out: i32):
      %7 = arith.addi %in, %in_2 : i32
      linalg.yield %7 : i32
    } -> tensor<i32>
    cf.br ^bb3(%5 : tensor<i32>)
  ^bb3(%6: tensor<i32>):  // pred: ^bb2
    %cast = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

