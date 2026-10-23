module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-66> : tensor<3x9x2xi16>}> : () -> tensor<3x9x2xi16>
    %1 = "tosa.const"() <{values = dense<true> : tensor<7x5xi1>}> : () -> tensor<7x5xi1>
    %2 = "tosa.const"() <{values = dense<-85.1699981> : tensor<6xf32>}> : () -> tensor<6xf32>
    %3 = tosa.const_shape  {values = dense<[3, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.tile %0, %3 : (tensor<3x9x2xi16>, !tosa.shape<3>) -> tensor<9x18x2xi16>
    %5 = tosa.concat %4, %4 {axis = 2 : i32} : (tensor<9x18x2xi16>, tensor<9x18x2xi16>) -> tensor<9x18x4xi16>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<9x18x4xi16>) -> tensor<9x1x4xi16>
    %7 = tosa.bitwise_or %6, %6 : (tensor<9x1x4xi16>, tensor<9x1x4xi16>) -> tensor<9x1x4xi16>
    %8 = tosa.reduce_all %1 {axis = 0 : i32} : (tensor<7x5xi1>) -> tensor<1x5xi1>
    %9 = tosa.argmax %8 {axis = 1 : i32} : (tensor<1x5xi1>) -> tensor<1xi32>
    %10 = tosa.reciprocal %2 : (tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %7 : tensor<9x1x4xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %9 : tensor<1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

