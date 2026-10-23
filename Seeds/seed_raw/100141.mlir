#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"], library_call = "some_external_func"} ins(%0 : tensor<1x1xi32>) outs(%0 : tensor<1x1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %2 = linalg.index 0 : index
      %3 = linalg.index 1 : index
      %4 = arith.addi %2, %3 : index
      %5 = arith.index_cast %4 : index to i32
      %6 = arith.addi %5, %in : i32
      linalg.yield %6 : i32
    } -> tensor<1x1xi32>
    %cast = tensor.cast %1 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

