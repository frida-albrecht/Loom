module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.477000e+01> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %1 = tosa.reciprocal %0 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %2 = tosa.log %1 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %cast = tensor.cast %3 : tensor<6x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

