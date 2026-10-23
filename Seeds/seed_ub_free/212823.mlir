module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<28> : tensor<2x6x8x6xi64>}> : () -> tensor<2x6x8x6xi64>
    %1 = tosa.reduce_product %0 {axis = 3 : i32} : (tensor<2x6x8x6xi64>) -> tensor<2x6x8x1xi64>
    %cast = tensor.cast %1 : tensor<2x6x8x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

