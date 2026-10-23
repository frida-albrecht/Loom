module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.698900e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %1 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

