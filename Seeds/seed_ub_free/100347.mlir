#map = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-123> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<8xi32>) {
    ^bb0(%out: i32):
      linalg.yield %out : i32
    } -> tensor<8xi32>
    %cast = tensor.cast %1 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

