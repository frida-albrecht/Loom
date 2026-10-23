module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<3x3x4x10xi8>}> : () -> tensor<3x3x4x10xi8>
    %1 = "tosa.const"() <{values = dense<18> : tensor<3x3x4x10xi8>}> : () -> tensor<3x3x4x10xi8>
    %2 = "tosa.const"() <{values = dense<9.152000e+01> : tensor<9x3x8xf32>}> : () -> tensor<9x3x8xf32>
    %3 = "tosa.const"() <{values = dense<-121> : tensor<4x5x9x5xi32>}> : () -> tensor<4x5x9x5xi32>
    %4 = "tosa.const"() <{values = dense<80> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %5 = tosa.bitwise_or %0, %1 : (tensor<3x3x4x10xi8>, tensor<3x3x4x10xi8>) -> tensor<3x3x4x10xi8>
    %6 = tosa.tanh %2 : (tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %7 = tosa.reduce_product %5 {axis = 2 : i32} : (tensor<3x3x4x10xi8>) -> tensor<3x3x1x10xi8>
    %8 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %9 = tosa.transpose %6 {perms = array<i32: 0, 2, 1>} : (tensor<9x3x8xf32>) -> tensor<9x8x3xf32>
    %10 = tosa.intdiv %3, %4 : (tensor<4x5x9x5xi32>, tensor<1x1x1x1xi32>) -> tensor<4x5x9x5xi32>
    %cast = tensor.cast %7 : tensor<3x3x1x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<9x8x3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<4x5x9x5xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

