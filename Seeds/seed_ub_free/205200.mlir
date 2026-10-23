module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-124> : tensor<8x7x8x2xi64>}> : () -> tensor<8x7x8x2xi64>
    %1 = "tosa.const"() <{values = dense<1.068600e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = tosa.abs %0 : (tensor<8x7x8x2xi64>) -> tensor<8x7x8x2xi64>
    %3 = tosa.sigmoid %1 : (tensor<4xf32>) -> tensor<4xf32>
    %4 = tosa.bitwise_xor %2, %2 : (tensor<8x7x8x2xi64>, tensor<8x7x8x2xi64>) -> tensor<8x7x8x2xi64>
    %5 = tosa.argmax %4 {axis = 3 : i32} : (tensor<8x7x8x2xi64>) -> tensor<8x7x8xi32>
    %6 = tosa.tanh %3 : (tensor<4xf32>) -> tensor<4xf32>
    %c1 = "tosa.const"() <{values = dense<1> : tensor<8x7x8xi32>}> : () -> tensor<8x7x8xi32>
    %s1 = tosa.maximum %5, %c1 : (tensor<8x7x8xi32>, tensor<8x7x8xi32>) -> tensor<8x7x8xi32>
    %7 = tosa.intdiv %5, %s1 : (tensor<8x7x8xi32>, tensor<8x7x8xi32>) -> tensor<8x7x8xi32>
    %8 = tosa.floor %6 : (tensor<4xf32>) -> tensor<4xf32>
    %9 = tosa.reduce_min %8 {axis = 0 : i32} : (tensor<4xf32>) -> tensor<1xf32>
    %cast = tensor.cast %7 : tensor<8x7x8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}