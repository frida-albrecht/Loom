#map = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<176> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "tosa.const"() <{values = dense<-115> : tensor<8xi32>}> : () -> tensor<8xi32>
    %c0_i32 = arith.constant 0 : i32
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%0 : tensor<8xi32>) outs(%1 : tensor<8xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %c0_i32 : i32
    } -> tensor<8xi32>
    %cast = tensor.cast %2 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

