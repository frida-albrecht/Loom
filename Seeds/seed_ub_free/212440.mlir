module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<197> : tensor<6x4x2x8xi64>}> : () -> tensor<6x4x2x8xi64>
    %1 = tosa.reduce_product %0 {axis = 2 : i32} : (tensor<6x4x2x8xi64>) -> tensor<6x4x1x8xi64>
    %cast = tensor.cast %1 : tensor<6x4x1x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

