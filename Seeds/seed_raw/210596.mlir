module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<6x3x1x8xi64>}> : () -> tensor<6x3x1x8xi64>
    %1 = "tosa.const"() <{values = dense<-8> : tensor<6x3x1x45xi64>}> : () -> tensor<6x3x1x45xi64>
    %2 = "tosa.const"() <{values = dense<-1.386400e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.concat %0, %1 {axis = 3 : i32} : (tensor<6x3x1x8xi64>, tensor<6x3x1x45xi64>) -> tensor<6x3x1x53xi64>
    %4 = tosa.sigmoid %2 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.bitwise_xor %3, %3 : (tensor<6x3x1x53xi64>, tensor<6x3x1x53xi64>) -> tensor<6x3x1x53xi64>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6x3x1x53xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

