module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<140> : tensor<8x7x7x9xi64>}> : () -> tensor<8x7x7x9xi64>
    %1 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<8x7x7x9xi64>) -> tensor<8x7x1x9xi64>
    %2 = tosa.concat %1, %1 {axis = 2 : i32} : (tensor<8x7x1x9xi64>, tensor<8x7x1x9xi64>) -> tensor<8x7x2x9xi64>
    %3 = tosa.clamp %2 {max_val = 98 : i64, min_val = -18 : i64} : (tensor<8x7x2x9xi64>) -> tensor<8x7x2x9xi64>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<8x7x2x9xi64>) -> tensor<1x7x2x9xi64>
    %5 = tosa.reduce_min %4 {axis = 1 : i32} : (tensor<1x7x2x9xi64>) -> tensor<1x1x2x9xi64>
    %cast = tensor.cast %5 : tensor<1x1x2x9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

