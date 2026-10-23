module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<10x3x6xi64>}> : () -> tensor<10x3x6xi64>
    %1 = "tosa.const"() <{values = dense<-188> : tensor<10x6x10xi64>}> : () -> tensor<10x6x10xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<10x3x6xi64>, tensor<10x6x10xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<10x3x10xi64>
    %5 = tosa.bitwise_or %4, %4 : (tensor<10x3x10xi64>, tensor<10x3x10xi64>) -> tensor<10x3x10xi64>
    %6 = tosa.reverse %5 {axis = 1 : i32} : (tensor<10x3x10xi64>) -> tensor<10x3x10xi64>
    %7 = tosa.add %6, %6 : (tensor<10x3x10xi64>, tensor<10x3x10xi64>) -> tensor<10x3x10xi64>
    %8 = tosa.bitwise_xor %7, %5 : (tensor<10x3x10xi64>, tensor<10x3x10xi64>) -> tensor<10x3x10xi64>
    %9 = tosa.reverse %8 {axis = 1 : i32} : (tensor<10x3x10xi64>) -> tensor<10x3x10xi64>
    %10 = tosa.logical_left_shift %9, %9 : (tensor<10x3x10xi64>, tensor<10x3x10xi64>) -> tensor<10x3x10xi64>
    %11 = tosa.const_shape  {values = dense<[1, 1, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %12 = tosa.tile %10, %11 : (tensor<10x3x10xi64>, !tosa.shape<3>) -> tensor<10x3x30xi64>
    %13 = tosa.argmax %12 {axis = 0 : i32} : (tensor<10x3x30xi64>) -> tensor<3x30xi32>
    %cast = tensor.cast %13 : tensor<3x30xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

