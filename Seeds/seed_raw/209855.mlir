module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<86> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-169> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<-125> : tensor<3x10x5xi32>}> : () -> tensor<3x10x5xi32>
    %3 = "tosa.const"() <{values = dense<13> : tensor<3x10x5xi32>}> : () -> tensor<3x10x5xi32>
    %4 = tosa.logical_right_shift %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %5 = tosa.intdiv %2, %3 : (tensor<3x10x5xi32>, tensor<3x10x5xi32>) -> tensor<3x10x5xi32>
    %6 = tosa.const_shape  {values = dense<[2, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.tile %5, %6 : (tensor<3x10x5xi32>, !tosa.shape<3>) -> tensor<6x30x10xi32>
    %cast = tensor.cast %4 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<6x30x10xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

