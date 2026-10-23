module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<159> : tensor<9xi32>}> : () -> tensor<9xi32>
    %1 = "tosa.const"() <{values = dense<53> : tensor<9xi32>}> : () -> tensor<9xi32>
    %2 = tosa.minimum %0, %1 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %3 = tosa.identity %2 : (tensor<9xi32>) -> tensor<9xi32>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<9xi32>) -> tensor<1xi32>
    %cast = tensor.cast %4 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

